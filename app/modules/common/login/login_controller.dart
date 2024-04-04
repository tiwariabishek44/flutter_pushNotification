import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:merocanteen/app/config/prefs.dart';
import 'package:merocanteen/app/models/canteen_model.dart';
import 'package:merocanteen/app/models/users_model.dart';
import 'package:merocanteen/app/modules/common/loginoption/login_option_controller.dart';
import 'package:merocanteen/app/repository/canteen_data_repository.dart';
import 'package:merocanteen/app/repository/get_userdata_repository.dart';
import 'package:merocanteen/app/service/api_client.dart';
import 'package:merocanteen/app/widget/custom_snackbar.dart';
import 'package:merocanteen/app/widget/splash_screen.dart';

class LoginController extends GetxController {
  final storage = GetStorage();
  // TextEditingController for the email field
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final loginOptionController = Get.put(LoginScreenController());

  final vendorCode = TextEditingController();

  var isloading = false.obs;
  var isFetchLoading = false.obs;
  final loginFromkey = GlobalKey<FormState>();
  final termsAndConditions = false.obs;
  final vendorLoginFromkey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<UserDataResponse?> user = Rx<UserDataResponse?>(null);

  @override
  void onInit() {
    super.onInit();
  }

  void loginSubmit(BuildContext context) {
    if (loginFromkey.currentState!.validate()) {
      login(context);
    }
  }

  //---------user login----------
  Future<void> login(BuildContext context) async {
    try {
      isloading(true);

      // Attempt to sign in
      await _auth.signInWithEmailAndPassword(
          email: emailcontroller.text, password: passwordcontroller.text);

      if (loginOptionController.isUser.value) {
        saveDataLocally(context);
      } else {
        bool canteenExists = await checkIfCanteenExists(_auth.currentUser!.uid);

        if (canteenExists) {
          saveDataLocally(context);
        } else {
          // Perform both sign-out and display the login failure dialog
          await _auth.signOut();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  "Login Failed",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.red,
                  ),
                ),
                content: Text(
                  "You are not allowed to login as canteen.",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      }

      isloading(false);
    } on FirebaseAuthException catch (e) {
      isloading(false);

      // Handle FirebaseAuthException (Firebase authentication errors)
      String errorMessage = 'An error occurred';
      if (e.code == 'user-not-found') {
        errorMessage = 'User not found. Please register first.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Invalid password. Please try again.';
      } else {
        errorMessage = 'Login failed. Please try again later.';
      }
      CustomSnackbar.authShowFailure(context, errorMessage);
    } on PlatformException catch (e) {
      isloading(false);

      // Handle platform exceptions (e.g., no internet connection)
      if (e.code == 'network_error') {
        CustomSnackbar.authShowFailure(context, "No internet connection");
      } else {
        CustomSnackbar.authShowFailure(context, "An error occurred");
      }
    } catch (e) {
      isloading(false);

      // Handle other errors
      print("Login error: $e");
      CustomSnackbar.authShowFailure(context, "An unexpected error occurred");
    } finally {
      // Turn off loading indicator regardless of success or failure
      isloading(false);
    }
  }

//----------------TO CHECK IF THE CANTEEN EXIST OR NOT------------
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> checkIfCanteenExists(String userId) async {
    try {
      // Query the "canteen" collection using the provided user ID
      QuerySnapshot querySnapshot = await _firestore
          .collection('canteen')
          .where('userid', isEqualTo: userId)
          .get();

      // Return true if data exists for the user in the "canteen" collection
      return querySnapshot.docs.isNotEmpty ? true : false;
    } catch (e) {
      // Handle errors
      print("Error checking if canteen exists: $e");
      return false; // Return false in case of error
    }
  }

//---------to fetch the user data------------
  final UserDataRepository userDataRepository = UserDataRepository();
  final Rx<ApiResponse<UserDataResponse>> userDataResponse =
      ApiResponse<UserDataResponse>.initial().obs;
  Future<void> fetchUserData() async {
    try {
      isFetchLoading(true);
      userDataResponse.value = ApiResponse<UserDataResponse>.loading();
      final userDataResult = await userDataRepository.getUserData(
        {
          'userid': storage.read(userId),
          // Add more filters as needed
        },
      );
      if (userDataResult.status == ApiStatus.SUCCESS) {
        userDataResponse.value =
            ApiResponse<UserDataResponse>.completed(userDataResult.response);
        isFetchLoading(false);

        log(userDataResponse.value.response!.first.classes);
      }
      isFetchLoading(false);
    } catch (e) {
      isFetchLoading(false);

      log('Error while getting data: $e');
    } finally {
      isFetchLoading(false);
    }
  }

//-------------fetch the vendor data-----------------

  final CanteenDataRepository canteenDataRepository = CanteenDataRepository();
  final Rx<ApiResponse<CanteenDataResponse>> canteenDataResponse =
      ApiResponse<CanteenDataResponse>.initial().obs;
  Future<void> fetchCanteenData(BuildContext context) async {
    try {
      isFetchLoading(true);
      canteenDataResponse.value = ApiResponse<CanteenDataResponse>.loading();
      final canteenDataResult = await canteenDataRepository.getCanteenData(
        {
          'userid': storage.read(userId),
          // Add more filters as needed
        },
      );
      if (canteenDataResult.status == ApiStatus.SUCCESS) {
        canteenDataResponse.value = ApiResponse<CanteenDataResponse>.completed(
            canteenDataResult.response);
        isFetchLoading(false);
      } else {
        isFetchLoading(false);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Login Failed"),
              content: Text("Sorry, you cannot login."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
      isFetchLoading(false);
    } catch (e) {
      isFetchLoading(false);

      log('Error while getting data: $e');
    } finally {
      isFetchLoading(false);
    }
  }

//-------- to save data locally

  void saveDataLocally(BuildContext context) {
    storage.write(userId, _auth.currentUser!.uid);
    storage.write(
        userType, loginOptionController.isUser.value ? student : canteen);
    loginOptionController.isUser.value
        ? fetchUserData()
        : fetchCanteenData(context);
    log("this is the user login option${storage.read(userType)}");
    Get.offAll(() => SplashScreen());
  }

//-------to do auto login---------
  bool autoLogin() {
    log("AUTO LOGIN  ${storage.read(userType)}");
    if (storage.read(userType) != null) {
      // set a periodic timer to refresh token
      return true;
    }
    return false;
  }

//--to do logout------------------
  Future<void> logout() async {
    try {
      await _auth.signOut();
      user.value = null;
      storage.remove(
        userId,
      );

      storage.remove(userType);
      Get.offAll(() => SplashScreen());
    } catch (e) {
      // Handle logout errors
      Get.snackbar("Logout Failed", e.toString());
    }
  }

//------------vendor/canteen login---------------//

  void vendorloginSubmit() {
    if (vendorLoginFromkey.currentState!.validate()) {
      vendorLogin();
    }
  }

  Future<void> vendorLogin() async {
    try {
      isloading(true);

      if (vendorCode.text.trim() == '4455') {
        storage.write(userType, "canteen");
        Get.offAll(() => SplashScreen());
        isloading(false);
        vendorCode.clear();
      } else {
        Get.snackbar("Error", 'Enter the valid number');

        isloading(false);
      }
    } catch (e) {
      isloading(false);
      // Handle login errors
      print("Login error: $e");
      Get.snackbar("Login Failed", e.toString());
    }
  }

//------------vendor logout---------------//

  Future<void> vendorLogOut() async {
    try {
      storage.remove(userType);
      vendorCode.clear();

      Get.offAll(() => SplashScreen());
    } catch (e) {
      isloading(false);
      // Handle login errors
      print("Login error: $e");
      Get.snackbar("Login Failed", e.toString());
    }
  }

  String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address';
    }
    // Check if the entered email has the right format
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    // Return null if the entered email is valid
    return null;
  }

  String? vendorVlidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your Canteen Code';
    }

    // Return null if the entered email is valid
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    // Check for additional criteria (e.g., at least one digit and one special character)

    return null; // Return null if the password meets the criteria
  }
}

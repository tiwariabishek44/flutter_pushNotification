import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merocanteen/app/modules/common/register/register.dart';

class UserNameController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final namecontroller = TextEditingController();
  final isloaidng = false.obs;

  Future<void> checkUsername() async {
    try {
      isloaidng(true);
      QuerySnapshot usernameSnapshot = await _firestore
          .collection('studentusername')
          .where('username', isEqualTo: namecontroller.text.trim())
          .get();

      if (usernameSnapshot.docs.isNotEmpty) {
        var doc = usernameSnapshot.docs.first;
        bool isOccupied = doc['isOccupied'];

        if (isOccupied) {
          isloaidng(false);
          // Username is occupied
          Get.snackbar('Username Status', 'Username is already occupied',
              snackPosition: SnackPosition.TOP);
        } else {
          isloaidng(false);
          Get.to(() => RegisterPage());
        }
      } else {
        isloaidng(false);

        // Username does not exist
        Get.snackbar('Username Status', 'Username does not exist',
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      isloaidng(false);

      print('Error checking username: $e');
      Get.snackbar('Error', 'An error occurred while checking username',
          snackPosition: SnackPosition.TOP);
    }
  }

  String? usernameValidator(String? value) {
    // if(fieldLostFocus == usernameController.hashCode)
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    if (value.trim().length != 4) {
      return 'Username must be of 4 characters in length';
    }
    // Return null if the entered username is valid
    return null;
  }
}

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:merocanteen/app/models/group_api_response.dart';
import 'package:merocanteen/app/models/users_model.dart';
import 'package:merocanteen/app/modules/common/login/login_controller.dart';
import 'package:merocanteen/app/modules/user_module/group/view/group.dart';
import 'package:merocanteen/app/repository/fetch_groupmenber_repository.dart';
import 'package:merocanteen/app/repository/get_group_repository.dart';
import 'package:merocanteen/app/repository/group_member_delete_repository.dart';
import 'package:merocanteen/app/service/api_client.dart';
import 'package:merocanteen/app/widget/custom_snackbar.dart';

class GroupController extends GetxController {
  final logincontroller = Get.put(LoginController());
  final storage = GetStorage();
  final groupnameController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var deleteMemberLoading = false.obs;

  final RxList<UserDataResponse> students = <UserDataResponse>[].obs;
  Rx<GroupApiResponse?> currentGroup = Rx<GroupApiResponse?>(null);

  var isloading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchGroupData();
    fecthGroupMember();
  }

//--------------create a new grou-----------//
//   Future<void> createNewGroup() async {
//     isloading(true);

//     try {
//       String pinString;

//       // Loop until a unique PIN is generated
//       while (true) {
//         // Generate a random 4-digit PIN
//         Random random = Random();
//         int pin = random.nextInt(10000);
//         pinString = pin.toString().padLeft(4, '0');

//         // Check if the PIN already exists in the collection
//         DocumentSnapshot pinSnapshot =
//             await _firestore.collection('AssignedPins').doc(pinString).get();

//         if (!pinSnapshot.exists) {
//           // If the PIN doesn't exist, break out of the loop
//           break;
//         }
//       }

//       // Upload the unique PIN to the 'AssignedPins' collection
//       await _firestore.collection('AssignedPins').doc(pinString).set({
//         'assigned': true,
//       });

//       String userId = _auth.currentUser!.uid;
//       GroupApiResponse newGroup = GroupApiResponse(
//         groupId: userId,
//         groupCode: pinString,
//         groupName: groupnameController.text.trim(),
//         moderator: logincontroller.user.value!.name,
//       );

//       // Add the new group to the 'groups' collection
//       await _firestore.collection('groups').add(newGroup.toJson());

//       // Update the user's 'groupid' field in the 'students' collection
//       final FirebaseFirestore firestore = FirebaseFirestore.instance;
//       final studentDocRef = firestore.collection('students').doc(userId);
//       await studentDocRef.update({'groupid': userId});

//       logincontroller.fetchUserData();
//       fecthGroupMember();
//       Get.back();
//       isloading(false);
//       print('Pin $pinString uploaded successfully!');
//     } catch (e) {
//       isloading(false);
//       print('Error: $e');
//     }
//   }

//---------to fetch the group  data------------
  final GetGroupRepository groupRepository = GetGroupRepository();
  final Rx<ApiResponse<GroupApiResponse>> groupResponse =
      ApiResponse<GroupApiResponse>.initial().obs;
  Future<void> fetchGroupData() async {
    try {
      isloading(true);
      groupResponse.value = ApiResponse<GroupApiResponse>.loading();
      final groupResult = await groupRepository.getGroupData(
          logincontroller.userDataResponse.value.response!.first.groupid);
      if (groupResult.status == ApiStatus.SUCCESS) {
        debugPrint("----------this is the success t fetch the user data");
        groupResponse.value =
            ApiResponse<GroupApiResponse>.completed(groupResult.response);
        fecthGroupMember();
      }
    } catch (e) {
      isloading(false);

      debugPrint('Error while getting data: $e');
    } finally {
      isloading(false);
    }
  }

//------------fetch the group members ----------//

  final FetchGroupMemberRepository groupMemberRepository =
      FetchGroupMemberRepository();
  final Rx<ApiResponse<UserDataResponse>> groupMemberResponse =
      ApiResponse<UserDataResponse>.initial().obs;
  Future<void> fecthGroupMember() async {
    try {
      debugPrint("--------Fetching all the group members=======");
      isloading(true);
      groupMemberResponse.value = ApiResponse<UserDataResponse>.loading();
      final groupMemberResult = await groupMemberRepository.getGroupMember(
          logincontroller.userDataResponse.value.response!.first.groupid);
      if (groupMemberResult.status == ApiStatus.SUCCESS) {
        groupMemberResponse.value =
            ApiResponse<UserDataResponse>.completed(groupMemberResult.response);

        log("group member is fetch---------");
      }
    } catch (e) {
      isloading(false);

      debugPrint('Error while getting data: $e');
    } finally {
      isloading(false);
    }
  }

  ///-----------to fetchall student of class----------//

//-----------add friends in group----------//
  Future<void> addFriends(String studentid) async {
    try {
      isloading(true);
      String userId = _auth.currentUser!.uid;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get the document reference for the current user
      final DocumentSnapshot<Map<String, dynamic>> studentDocSnapshot =
          await firestore.collection('students').doc(studentid).get();
      await studentDocSnapshot.reference.update({'groupid': userId});
      fecthGroupMember();

      isloading(false);
    } catch (e) {
      // Document for the user doesn't exist, handle this case

      print('Error adding friends: $e');
      // Add further error handling logic if needed
    }
  }

  final deleteGroupMemberRepository =
      GroupMemberDeleteRepository(); // Instantiate AddFriendRepository

  Future<void> deleteMember(BuildContext context, String studentId) async {
    try {
      deleteMemberLoading(true);
      final response =
          await deleteGroupMemberRepository.deleteGroupMember(studentId);
      if (response.status == ApiStatus.SUCCESS) {
        fecthGroupMember();

        deleteMemberLoading(false);
      } else {
        deleteMemberLoading(false);
      }
    } catch (e) {
      deleteMemberLoading(false);
    } finally {
      deleteMemberLoading(false);
    }
  }
}

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merocanteen/app/models/users_model.dart';
import 'package:merocanteen/app/modules/common/login/login_controller.dart';
import 'package:merocanteen/app/modules/user_module/group/group_controller.dart';
import 'package:merocanteen/app/repository/add_friend_repository.dart';
import 'package:merocanteen/app/repository/get_friend_list_repository.dart';
import 'package:merocanteen/app/service/api_client.dart';

class FriendListController extends GetxController {
  final loginController = Get.put(LoginController());
  final groupContorller = Get.put(GroupController());
  var fetchLoading = false.obs;
  var addFriendLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFrields();
  }

  final friendRepository = GetFriendRepository();
  final Rx<ApiResponse<UserDataResponse>> friendListResponse =
      ApiResponse<UserDataResponse>.initial().obs;
  Future<void> fetchFrields() async {
    try {
      fetchLoading(true);
      friendListResponse.value = ApiResponse<UserDataResponse>.loading();
      final friendsResults = await friendRepository.getallfriends(
          loginController.userDataResponse.value.response!.first.classes);
      if (friendsResults.status == ApiStatus.SUCCESS) {
        friendListResponse.value =
            ApiResponse<UserDataResponse>.completed(friendsResults.response);

        log("this is the all product response  " +
            friendListResponse.value.response!.length.toString());
      }
    } catch (e) {
      fetchLoading(false);

      log('Error while getting data: $e');
    } finally {
      fetchLoading(false);
    }
  }

  final addFriendRepository =
      AddFriendRepository(); // Instantiate AddFriendRepository

  Future<void> addFriend(
      BuildContext context, String studentId, String groupId) async {
    try {
      addFriendLoading(true);
      final response = await addFriendRepository.addFriend(studentId, groupId);
      if (response.status == ApiStatus.SUCCESS) {
        log("Friend added successfully");
        fetchFrields();
        groupContorller.fecthGroupMember();

        addFriendLoading(false);
      } else {
        log("Failed to add friend: ${response.message}");
        addFriendLoading(false);
      }
    } catch (e) {
      addFriendLoading(false);
      log('Error while adding friend: $e');
    } finally {
      addFriendLoading(false);
    }
  }
}

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:merocanteen/app/models/order_response.dart';
import 'package:merocanteen/app/modules/common/login/login_controller.dart';
import 'package:merocanteen/app/repository/get_user_order_repository.dart';
import 'package:merocanteen/app/repository/order_checout_repository.dart';
import 'package:merocanteen/app/service/api_client.dart';
import 'package:merocanteen/app/widget/custom_snackbar.dart';
import 'package:nepali_utils/nepali_utils.dart';

class CanteenHoldOrders extends GetxController {
  var isOrderFetch = false.obs;
  var isloading = false.obs;
  var holdLoading = false.obs;
  final groupcod = TextEditingController();
  var updateGroupCode = ''.obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    fetchHoldOrders();
    log("this is delete");
  }

//------------fetch the user orders---------------
  final orderRepository = CheckoutRepository();
  final Rx<ApiResponse<OrderResponse>> orderResponse =
      ApiResponse<OrderResponse>.initial().obs;
  Future<void> fetchOrders(String groupId) async {
    try {
      log(groupId);
      isloading(true);

      orderResponse.value = ApiResponse<OrderResponse>.loading();
      final orderResult = await orderRepository.getOrders(groupId);
      if (orderResult.status == ApiStatus.SUCCESS) {
        orderResponse.value =
            ApiResponse<OrderResponse>.completed(orderResult.response);
        log('----orders is been fetch');

        log("this is the all product response  " +
            orderResponse.value.response!.length.toString());
        if (orderResponse.value.response!.length != 0) {
          isOrderFetch(true);
          updateGroupCode.value = groupId;
        } else {
          isOrderFetch(false);
        }
      }
    } catch (e) {
      isloading(false);

      log('Error while getting data: $e');
    } finally {
      isloading(false);
    }
  }

//-----------------hold the user orders-----------
  Future<void> holdUserOrder(
      BuildContext context, String orderId, String date) async {
    try {
      holdLoading(true);
      final response = await orderRepository.holdOrder(orderId, date);
      if (response.status == ApiStatus.SUCCESS) {
        log("Hold Succesfully");
        fetchHoldOrders();
        // ignore: use_build_context_synchronously
        CustomSnackbar.showSuccess(
            context, "Your order is been hold  condition");
        Get.back();

        holdLoading(false);
      } else {
        log("Failed to add friend: ${response.message}");
        holdLoading(false);
      }
    } catch (e) {
      holdLoading(false);
      log('Error while adding friend: $e');
    } finally {
      holdLoading(false);
    }
  }

//-------------------get hold orders------------//
  final Rx<ApiResponse<OrderResponse>> holdOrderResponse =
      ApiResponse<OrderResponse>.initial().obs;
  Future<void> fetchHoldOrders() async {
    try {
      isloading(true);
      holdOrderResponse.value = ApiResponse<OrderResponse>.loading();
      final orderResult = await orderRepository.getHoldOrders();
      if (orderResult.status == ApiStatus.SUCCESS) {
        holdOrderResponse.value =
            ApiResponse<OrderResponse>.completed(orderResult.response);
        log('----HOLD ORDERS ARE FETCHS');

        log("this is the all product response  " +
            holdOrderResponse.value.response!.length.toString());
      }
    } catch (e) {
      isloading(false);

      log('Error while getting data: $e');
    } finally {
      isloading(false);
    }
  }
}

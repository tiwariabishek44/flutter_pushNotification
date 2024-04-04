import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:merocanteen/app/models/order_response.dart';
import 'package:merocanteen/app/modules/common/login/login_controller.dart';
import 'package:merocanteen/app/repository/get_user_order_repository.dart';
import 'package:merocanteen/app/service/api_client.dart';
import 'package:merocanteen/app/widget/custom_snackbar.dart';
import 'package:nepali_utils/nepali_utils.dart';

class OrderController extends GetxController {
  final loginController = Get.put(LoginController());
  var isLoading = false.obs;
  var holdLoading = false.obs;
  var orderLoded = false.obs;

  @override
  void onInit() {
    super.onInit();
    void checkTimeAndSetDate() {
      DateTime currentDate = DateTime.now();
      NepaliDateTime nepaliDateTime = NepaliDateTime.fromDateTime(currentDate);

      dat.value = DateFormat('dd/MM/yyyy\'', 'en').format(nepaliDateTime);
    }

    fetchOrders();
    fetchHoldOrders();

    log("----ORDER CONTROLLER IS INITILIZE");
  }

  var dat = ''.obs;

//------------fetch the user orders---------------
  final orderRepository = UserOrederRepository();
  final Rx<ApiResponse<OrderResponse>> orderResponse =
      ApiResponse<OrderResponse>.initial().obs;
  Future<void> fetchOrders() async {
    try {
      isLoading(true);
      orderResponse.value = ApiResponse<OrderResponse>.loading();
      final orderResult = await orderRepository.getOrders(
        loginController.userDataResponse.value.response!.first.groupid,
      );
      if (orderResult.status == ApiStatus.SUCCESS) {
        orderResponse.value =
            ApiResponse<OrderResponse>.completed(orderResult.response);
        log('----orders is been fetch');

        orderResponse.value.response!.length != 0
            ? orderLoded(true)
            : orderLoded(false);
      }
    } catch (e) {
      orderLoded(false);
      isLoading(false);

      log('Error while getting data: $e');
    } finally {
      orderLoded(false);
      isLoading(false);
    }
  }

//-----------------hold the user orders-----------
  Future<void> holdUserOrder(
      BuildContext context, String orderId, String date) async {
    try {
      holdLoading(true);
      final response = await orderRepository.holdOrder(orderId, date);
      if (response.status == ApiStatus.SUCCESS) {
        log("checkout Succesfully");
        fetchOrders();
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
      isLoading(true);
      holdOrderResponse.value = ApiResponse<OrderResponse>.loading();
      final orderResult = await orderRepository.getHoldOrders(
          loginController.canteenDataResponse.value.response!.first.userid);
      if (orderResult.status == ApiStatus.SUCCESS) {
        holdOrderResponse.value =
            ApiResponse<OrderResponse>.completed(orderResult.response);
        log('----orders is been fetch');

        log("this is the all product response  " +
            holdOrderResponse.value.response!.length.toString());
      }
    } catch (e) {
      isLoading(false);

      log('Error while getting data: $e');
    } finally {
      isLoading(false);
    }
  }

//-----------------schedule the hold order----------------//

  Future<void> scheduleHoldOrders(
      BuildContext context, String orderId, String date) async {
    try {
      holdLoading(true);
      final response = await orderRepository.orderSchedule(orderId, date);
      if (response.status == ApiStatus.SUCCESS) {
        log("checkout Succesfully");
        fetchOrders();
        fetchHoldOrders();
        // ignore: use_build_context_synchronously
        CustomSnackbar.showSuccess(context, "Your order is been schedule");
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
}

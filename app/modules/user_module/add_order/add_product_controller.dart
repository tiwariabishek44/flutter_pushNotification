import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:merocanteen/app/models/order_response.dart';
import 'package:merocanteen/app/modules/user_module/orders/orders_controller.dart';
import 'package:merocanteen/app/repository/add_order_repository.dart';
import 'package:merocanteen/app/service/api_client.dart';
import 'package:merocanteen/app/widget/custom_snackbar.dart';
import 'package:nepali_utils/nepali_utils.dart';

class AddProductController extends GetxController {
  final orderController = Get.put(OrderController());
  final AddOrderRepository orderRepository = AddOrderRepository();
  final Rx<ApiResponse<OrderResponse>> orderResponse =
      ApiResponse<OrderResponse>.initial().obs;
  var isLoading = false.obs;

  Future<void> addItemToOrder(
    BuildContext context, {
    required String customerImage,
    required String classs,
    required String customer,
    required String groupid,
    required String cid,
    required String productName,
    required String productImage,
    required double price,
    required int quantity,
    required String groupcod,
    required String checkout,
    required String mealtime,
    required String date,
  }) async {
    try {
      isLoading(true);
      DateTime now = DateTime.now();
      String productId =
          '${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}${now.millisecond}';
      log("--------------this is the order time ${now}");

      NepaliDateTime nepaliDateTime = NepaliDateTime.fromDateTime(now);
      final dat = DateFormat('HH:mm/dd/MM/yyyy\'', 'en').format(nepaliDateTime);

      final newItem = {
        "id": '${productId + customer + productName}',
        "mealtime": mealtime,
        "classs": classs,
        "date": date,
        "checkout": 'false',
        "customer": customer,
        "groupcod": groupcod,
        "groupid": groupid,
        "cid": cid,
        "productName": productName,
        "price": price,
        "quantity": quantity,
        "productImage": productImage,
        "orderType": 'regular',
        "holdDate": '',
        'orderTime': dat,
        "customerImage": customerImage
      };

      orderResponse.value = ApiResponse<OrderResponse>.loading();

      log("--------------product image");
      final addOrderResult = await orderRepository.addOrder(newItem);

      if (addOrderResult.status == ApiStatus.SUCCESS) {
        orderResponse.value =
            ApiResponse<OrderResponse>.completed(addOrderResult.response);
        log("the order has been placed");
        orderController.fetchOrders();
        isLoading(false);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              elevation: 0,
              title: Icon(Icons.check_circle, color: Colors.green, size: 48),
              content: Text('Order successful!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );

        // Navigate to home page or perform necessary actions upon successful login
      } else {
        isLoading(false);

        orderResponse.value = ApiResponse<OrderResponse>.error(
            addOrderResult.message ?? 'Error during product create Failed');
        // ignore: use_build_context_synchronously
        CustomSnackbar.showFailure(context, orderResponse.value.toString());
      }
    } catch (e) {
      isLoading(false);

      // If an error occurs during the process, you can handle it here
      log('Error adding item to orders: $e');
      // ignore: use_build_context_synchronously
      CustomSnackbar.showFailure(
          context, 'Failed to add item to orders. Please try again later.');
    }
  }
}

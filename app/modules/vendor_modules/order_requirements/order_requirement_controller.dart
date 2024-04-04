import 'dart:developer';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:merocanteen/app/models/order_response.dart';
import 'package:merocanteen/app/repository/order_requirement_repository.dart';
import 'package:merocanteen/app/service/api_client.dart';

class OrderRequestContoller extends GetxController {
  final OrderRequirementRepository orderRequirementRepository =
      OrderRequirementRepository();

  final Rx<ApiResponse<OrderResponse>> requirmentResponse =
      ApiResponse<OrderResponse>.initial().obs;

  final RxMap<String, int> totalQuantityPerProduct = <String, int>{}.obs;
  var date = ''.obs;
  final List<String> timeSlots = [
    'All',
    '8:30',
    '9:30',
    '11:30',
    '12:30',
    '1:30',
  ];

  final RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchMeal(int index, String date) async {
    fetchRequirement(timeSlots[index], date);
  }

  Future<void> fetchRequirement(String mealtime, String dates) async {
    try {
      isLoading(true);
      requirmentResponse.value = ApiResponse<OrderResponse>.loading();
      final orderResult =
          await orderRequirementRepository.getOrderRequirement(mealtime, dates);
      if (orderResult.status == ApiStatus.SUCCESS) {
        requirmentResponse.value =
            ApiResponse<OrderResponse>.completed(orderResult.response);
        log('Orders have been fetched');
        log("Number of products in the response: " +
            requirmentResponse.value.response!.length.toString());

        // Calculate total quantity after fetching orders
        calculateTotalQuantity(orderResult.response!);
      }
    } catch (e) {
      log('Error while getting data: $e');
    } finally {
      isLoading(false);
    }
  }

  final RxList<ProductQuantity> productQuantities = <ProductQuantity>[].obs;

  void calculateTotalQuantity(List<OrderResponse> orders) {
    totalQuantityPerProduct.clear();

    orders.forEach((order) {
      totalQuantityPerProduct.update(
        order.productName,
        (value) => value + order.quantity,
        ifAbsent: () => order.quantity,
      );
    });

    // Convert map to list of ProductQuantity objects
    productQuantities.value = totalQuantityPerProduct.entries
        .map((entry) => ProductQuantity(
              productName: entry.key,
              totalQuantity: entry.value,
            ))
        .toList();
  }
}

class ProductQuantity {
  final String productName;

  final int totalQuantity;

  ProductQuantity({
    required this.productName,
    required this.totalQuantity,
  });
}

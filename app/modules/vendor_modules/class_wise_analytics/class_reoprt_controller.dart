import 'dart:developer';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:merocanteen/app/models/order_response.dart';
import 'package:merocanteen/app/repository/class_report_repository.dart';
import 'package:merocanteen/app/repository/order_requirement_repository.dart';
import 'package:merocanteen/app/repository/remaning_orders_reository.dart';
import 'package:merocanteen/app/service/api_client.dart';

class ClassReportController extends GetxController {
  final ClassReportRepository classReportRepository = ClassReportRepository();

  final Rx<ApiResponse<OrderResponse>> classReportResponse =
      ApiResponse<OrderResponse>.initial().obs;

  final RxMap<String, int> totalQuantityPerRemaningProduct =
      <String, int>{}.obs;

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
      classReportResponse.value = ApiResponse<OrderResponse>.loading();
      final orderResult =
          await classReportRepository.getClassReport(mealtime, dates);
      if (orderResult.status == ApiStatus.SUCCESS) {
        classReportResponse.value =
            ApiResponse<OrderResponse>.completed(orderResult.response);
        log('Orders have been fetched');
        log("Number of products in the response: " +
            classReportResponse.value.response!.length.toString());

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
    totalQuantityPerRemaningProduct.clear();

    orders.forEach((order) {
      totalQuantityPerRemaningProduct.update(
        order.classs,
        (value) => value + order.quantity,
        ifAbsent: () => order.quantity,
      );
    });

    // Convert map to list of ProductQuantity objects
    productQuantities.value = totalQuantityPerRemaningProduct.entries
        .map((entry) => ProductQuantity(
              className: entry.key,
              price: calculateTotalPrice(entry.key, orders), // Calculate price
              totalQuantity: entry.value,
            ))
        .toList();
  }

  int calculateTotalPrice(String className, List<OrderResponse> orders) {
    return orders
        .where((order) => order.classs == className)
        .map((order) => order.quantity * order.price)
        .fold(0, (previousValue, price) => previousValue + price.toInt());
  }

//-----------------for the class order report---------------
  final Rx<ApiResponse<OrderResponse>> cremaningOrderResponse =
      ApiResponse<OrderResponse>.initial().obs;

  final RxMap<String, int> ctotalQuantityPerRemaningProduct =
      <String, int>{}.obs;

  Future<void> fetchRemaningMeal(int index, String date) async {
    fetchRemaing(timeSlots[index], date);
  }

  Future<void> fetchRemaing(String mealtime, String dates) async {
    try {
      isLoading(true);
      cremaningOrderResponse.value = ApiResponse<OrderResponse>.loading();
      final remaningOrderResult =
          await classReportRepository.getRemaningOrders(mealtime, dates);
      if (remaningOrderResult.status == ApiStatus.SUCCESS) {
        cremaningOrderResponse.value =
            ApiResponse<OrderResponse>.completed(remaningOrderResult.response);
        log('Orders have been fetched');
        log("Number of products in the response: " +
            cremaningOrderResponse.value.response!.length.toString());

        // Calculate total quantity after fetching orders
        calculateRemaningQuantity(remaningOrderResult.response!);
      }
    } catch (e) {
      log('Error while getting data: $e');
    } finally {
      isLoading(false);
    }
  }

  final RxList<ProductQuantity> remaningproductQuantities =
      <ProductQuantity>[].obs;

  void calculateRemaningQuantity(List<OrderResponse> orders) {
    ctotalQuantityPerRemaningProduct.clear();

    orders.forEach((order) {
      ctotalQuantityPerRemaningProduct.update(
        order.classs,
        (value) => value + order.quantity,
        ifAbsent: () => order.quantity,
      );
    });

    // Convert map to list of ProductQuantity objects
    remaningproductQuantities.value = ctotalQuantityPerRemaningProduct.entries
        .map((entry) => ProductQuantity(
              className: entry.key,
              price: calculateTotalPrice(entry.key, orders), // Calculate price
              totalQuantity: entry.value,
            ))
        .toList();
  }
}

class ProductQuantity {
  final String className;
  final int price;

  final int totalQuantity;

  ProductQuantity({
    required this.className,
    required this.price,
    required this.totalQuantity,
  });
}

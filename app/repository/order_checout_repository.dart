import 'dart:developer';

import 'package:merocanteen/app/config/api_end_points.dart';
import 'package:merocanteen/app/models/order_response.dart';
import 'package:merocanteen/app/service/api_client.dart';

class CheckoutRepository {
  //-------checkout the group orders--------------

  Future<SingleApiResponse<void>> orderCheckout(String groupCode) async {
    final response = await ApiClient().update<void>(
      filters: {
        'groupcod': groupCode,
        'orderType': 'regular',
      },
      updateField: {'checkout': 'true'},
      collection: ApiEndpoints.orderCollection,
      responseType:
          (snapshot) {}, // Since responseType is not used for update operation
    );

    // Check if update was successful
    if (response.status == ApiStatus.SUCCESS) {
      // Update successful
      return SingleApiResponse.completed("Update successful");
    } else {
      // Update failed, return the response
      return response;
    }
  }

//checkoiut the single order

  Future<SingleApiResponse<void>> singleOrderCheckout(String orderId) async {
    final response = await ApiClient().update<void>(
      filters: {
        'id': orderId,
        'orderType': 'regular',
      },
      updateField: {'checkout': 'true'},
      collection: ApiEndpoints.orderCollection,
      responseType:
          (snapshot) {}, // Since responseType is not used for update operation
    );

    // Check if update was successful
    if (response.status == ApiStatus.SUCCESS) {
      // Update successful
      return SingleApiResponse.completed("Update successful");
    } else {
      // Update failed, return the response
      return response;
    }
  }

//-------------to get the orders------------
  Future<ApiResponse<OrderResponse>> getOrders(
    String groupCode,
  ) async {
    log('this is the group id $groupCode');
    final response = await ApiClient().getFirebaseData<OrderResponse>(
      collection: ApiEndpoints.orderCollection,
      filters: {
        "groupcod": groupCode,
        'checkout': 'false',
        'orderType': 'regular',

        // Add more filters as needed
      },
      responseType: (json) => OrderResponse.fromJson(json),
    );

    return response;
  }

//----------to hold the orders-------------
  Future<SingleApiResponse<void>> holdOrder(
      String groupCode, String date) async {
    final response = await ApiClient().update<void>(
      filters: {'id': groupCode},
      updateField: {'date': '', 'orderType': 'hold', 'holdDate': date},
      collection: ApiEndpoints.orderCollection,
      responseType:
          (snapshot) {}, // Since responseType is not used for update operation
    );

    // Check if update was successful
    if (response.status == ApiStatus.SUCCESS) {
      // Update successful
      return SingleApiResponse.completed("Update successful");
    } else {
      // Update failed, return the response
      return response;
    }
  }

  //-----------to get the hold orders-------------------
  Future<ApiResponse<OrderResponse>> getHoldOrders() async {
    final response = await ApiClient().getFirebaseData<OrderResponse>(
      collection: ApiEndpoints.orderCollection,
      filters: {
        'checkout': 'false',
        'orderType': 'hold',
        // Add more filters as needed
      },
      responseType: (json) => OrderResponse.fromJson(json),
    );

    return response;
  }
}

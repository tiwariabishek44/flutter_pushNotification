import 'dart:developer';

import 'package:merocanteen/app/config/api_end_points.dart';
import 'package:merocanteen/app/models/order_response.dart';
import 'package:merocanteen/app/service/api_client.dart';

class UserOrederRepository {
  Future<ApiResponse<OrderResponse>> getOrders(
    String groupId,
  ) async {
    log('this is the group id $groupId');
    final response = await ApiClient().getFirebaseData<OrderResponse>(
      collection: ApiEndpoints.orderCollection,
      filters: {
        "groupid": groupId,
        'checkout': 'false',
        'orderType': 'regular',

        // Add more filters as needed
      },
      responseType: (json) => OrderResponse.fromJson(json),
    );

    return response;
  }

//----------to hold the orders-------------
  Future<SingleApiResponse<void>> holdOrder(String orderId, String date) async {
    final response = await ApiClient().update<void>(
      filters: {'id': orderId},
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
  Future<ApiResponse<OrderResponse>> getHoldOrders(String cId) async {
    final response = await ApiClient().getFirebaseData<OrderResponse>(
      collection: ApiEndpoints.orderCollection,
      filters: {
        "cid": cId,
        'checkout': 'false',
        'orderType': 'hold',
        // Add more filters as needed
      },
      responseType: (json) => OrderResponse.fromJson(json),
    );

    return response;
  }

//----------to reshcedule the hold order-------------
  Future<SingleApiResponse<void>> orderSchedule(
      String orderId, String date) async {
    final response = await ApiClient().update<void>(
      filters: {'id': orderId},
      updateField: {
        'date': date,
        'orderType': 'regular',
      },
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
}

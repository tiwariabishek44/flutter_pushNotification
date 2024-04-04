import 'dart:developer';

import 'package:merocanteen/app/config/api_end_points.dart';
import 'package:merocanteen/app/models/order_response.dart';
import 'package:merocanteen/app/service/api_client.dart';

class OrderHistoryRepository {
  Future<ApiResponse<OrderResponse>> getGroupHistory(String groupId) async {
    log("calling the order history repository");
    final response = await ApiClient().getFirebaseData<OrderResponse>(
      collection: ApiEndpoints.orderCollection,
      filters: {
        "groupid": groupId,
        'checkout': 'true',
        'orderType': 'regular'

        // Add more filters as needed
      },
      responseType: (json) => OrderResponse.fromJson(json),
    );

    return response;
  }
}

import 'package:merocanteen/app/config/api_end_points.dart';
import 'package:merocanteen/app/models/order_response.dart';
import 'package:merocanteen/app/service/api_client.dart';

class GrandTotalRepository {
  Future<ApiResponse<OrderResponse>> getSalseReport(String date) async {
    final response = await ApiClient().getFirebaseData<OrderResponse>(
      collection: ApiEndpoints.orderCollection,
      filters: {
        "date": date,
        "checkout": "true",

        'orderType': 'regular',

        // Add more filters as needed
      },
      responseType: (json) => OrderResponse.fromJson(json),
    );

    return response;
  }

  Future<ApiResponse<OrderResponse>> getTotalOrders(String date) async {
    final response = await ApiClient().getFirebaseData<OrderResponse>(
      collection: ApiEndpoints.orderCollection,
      filters: {
        "date": date,
        'orderType': 'regular',

        // Add more filters as needed
      },
      responseType: (json) => OrderResponse.fromJson(json),
    );

    return response;
  }
}

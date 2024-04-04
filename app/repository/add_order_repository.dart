import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merocanteen/app/config/api_end_points.dart';
import 'package:merocanteen/app/models/order_response.dart';
import 'package:merocanteen/app/service/api_client.dart';

class AddOrderRepository {
  Future<ApiResponse<OrderResponse>> addOrder(
    requesBody,
  ) async {
    final response = await ApiClient().postFirebaseData<OrderResponse>(
      collection: ApiEndpoints.orderCollection,
      requestBody: requesBody,
      responseType: (json) => OrderResponse.fromJson(json),
    );

    return response;
  }
}

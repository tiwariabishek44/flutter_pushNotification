import 'package:merocanteen/app/config/api_end_points.dart';
import 'package:merocanteen/app/models/canteen_model.dart';
import 'package:merocanteen/app/service/api_client.dart';

class CanteenDataRepository {
  Future<ApiResponse<CanteenDataResponse>> getCanteenData(
      Map<String, dynamic> filters) async {
    final response = await ApiClient().getFirebaseData<CanteenDataResponse>(
      collection: ApiEndpoints.canteenCollection,
      filters: filters,
      responseType: (json) => CanteenDataResponse.fromJson(json),
    );

    return response;
  }
}

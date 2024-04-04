import 'package:merocanteen/app/config/api_end_points.dart';
import 'package:merocanteen/app/models/users_model.dart';
import 'package:merocanteen/app/service/api_client.dart';

class UserDataRepository {
  Future<ApiResponse<UserDataResponse>> getUserData(
      Map<String, dynamic> filters) async {
    final response = await ApiClient().getFirebaseData<UserDataResponse>(
      collection: ApiEndpoints.studentCollection,
      filters: filters,
      responseType: (json) => UserDataResponse.fromJson(json),
    );

    return response;
  }
}

import 'package:merocanteen/app/config/api_end_points.dart';
import 'package:merocanteen/app/models/users_model.dart';
import 'package:merocanteen/app/repository/get_userdata_repository.dart';
import 'package:merocanteen/app/service/api_client.dart';

class AddFriendRepository {
  Future<SingleApiResponse<void>> addFriend(
      String studentid, String groupId) async {
    final response = await ApiClient().update<void>(
      filters: {'userid': studentid},
      updateField: {'groupid': groupId},
      collection: ApiEndpoints.studentCollection,
      responseType: (snapshot) =>
          null, // Since responseType is not used for update operation
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

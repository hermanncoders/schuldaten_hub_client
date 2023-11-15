import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';

class SchooldayApi {
  // dio instance

  final client = locator<ApiManager>().dioClient.value;

  Future fetchSchooldayfromApi() async {
    try {
      final response = await client.get(Endpoints.getSchooldays);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}

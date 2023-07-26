import 'package:get/get.dart';
import 'package:sixam_mart_store/data/api/api_client.dart';
import 'package:sixam_mart_store/util/app_constants.dart';


class RequestRepo{
    final ApiClient apiClient;
    RequestRepo({required this.apiClient});

    Future<Response> fetchRequestInfoList(int offset) async {
    return await apiClient.getData('${AppConstants.userRequestsURI}?limit=15&offset=$offset');
  }
}
import 'package:get/get.dart';
import 'package:sixam_mart_store/data/api/api_client.dart';
import 'package:sixam_mart_store/util/app_constants.dart';


class CustomerListRepo{
    final ApiClient apiClient;
    CustomerListRepo({required this.apiClient});

    Future<Response> fetchRequestInfoList(String offset) async {
      print("FetchRequest Method");
    return await apiClient.getData('${AppConstants.customersUri}?limit=15&offset=$offset');
  }
}

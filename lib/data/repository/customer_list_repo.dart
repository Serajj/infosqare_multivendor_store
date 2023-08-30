import 'package:get/get.dart';
import 'package:sixam_mart_store/data/api/api_client.dart';
import 'package:sixam_mart_store/util/app_constants.dart';

class CustomerListRepo {
  final ApiClient apiClient;
  CustomerListRepo({required this.apiClient});

  Future<Response> fetchRequestInfoList(int offset, int storeId) async {
    print("FetchRequest Method");
    print(
        '${AppConstants.customersUri}?limit=15&offset=$offset&store=$storeId');
    return await apiClient.getData(
        '${AppConstants.customersUri}?limit=15&offset=$offset&store=$storeId');
  }

  Future<Response> followCustomer(int userId, int storeId) async {
    return await apiClient.postData('${AppConstants.followReq}',
        {"store_id": storeId, "customer_id": userId});
  }

  Future<Response> unfollowCustomer(int userId, int storeId) async {
    return await apiClient.postData('${AppConstants.unfollowReq}',
        {"store_id": storeId, "customer_id": userId});
  }

  Future<Response> acceptCustomerRequest(int userId, int storeId) async {
    return await apiClient.postData('${AppConstants.acceptReq}',
        {"store_id": storeId, "customer_id": userId});
  }
}

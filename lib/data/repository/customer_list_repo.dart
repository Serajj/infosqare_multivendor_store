import 'package:get/get.dart';
import 'package:sixam_mart_store/data/api/api_client.dart';
import 'package:sixam_mart_store/util/app_constants.dart';

class CustomerListRepo {
  final ApiClient apiClient;
  CustomerListRepo({required this.apiClient});

  Future<Response> fetchRequestInfoList(
      int offset, int storeId, String search) async {
    return await apiClient.getData(
        '${AppConstants.customersUri}?limit=15&offset=$offset&store=$storeId&search=$search');
  }

  Future<Response> followCustomer(int userId, int storeId) async {
    return await apiClient.postData('${AppConstants.followReq}',
        {"store_id": storeId, "customer_id": userId});
  }

  Future<Response> accept(int? userId, int storeId) async {
    return await apiClient.postData('${AppConstants.acceptReq}',
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

  Future<Response> getAllRequestList(
      int offset, int type, int stype, int storeId, search) async {
    return await apiClient.getData(
        '${AppConstants.allRequests}?offset=$offset&limit=15&status=$type&storeId=$storeId&search=$search&type=$stype');
  }

  Future<Response> unfollowUser(int? userId, int storeId) async {
    return await apiClient.postData('${AppConstants.unfollowUser}',
        {"store_id": storeId, "customer_id": userId});
  }
}

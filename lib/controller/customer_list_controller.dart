import 'package:connectuz_store/data/api/api_checker.dart';
import 'package:connectuz_store/data/api/api_client.dart';
import 'package:connectuz_store/data/model/response/customer_list_model.dart';
import 'package:connectuz_store/data/repository/customer_list_repo.dart';
import 'package:get/get.dart';

import '../data/model/response/follower_model.dart';
import '../data/model/response/store_list_model.dart';
import '../data/model/response/user_follow_model.dart';
import 'auth_controller.dart';
import 'store_controller.dart';

class CustomerListController extends GetxController {
  RxInt offset = 1.obs;

  RxBool isLoadingAll = true.obs;
  RxInt offsetReq = 1.obs;
  RxInt offsetAccepted = 1.obs;
  RxString search = "".obs;
  RxBool isLoading = true.obs;
  RxBool isLoadingAccept = true.obs;
  RxBool isLoadingReq = true.obs;
  RxList<Follower> dataListRecieved = <Follower>[].obs;
  RxList<Follower> dataListAccepted = <Follower>[].obs;
  CustomerListRepo customerListRepo = CustomerListRepo(apiClient: Get.find());

  CustomerListController() {}

  List<CustomerModel>? _customerList;
  RxList<UserFollow> dataList = <UserFollow>[].obs;

  List<CustomerModel>? get customerList => _customerList;

  Future<void> fetchCustomersList() async {
    if (search.value.isEmpty) {
      dataList.clear();
      isLoading.value = false;

      return;
    }
    if (offset.value == 1) {
      isLoading.value = true;
      dataList.clear();
    }
    int storeId = Get.find<AuthController>().profileModel!.stores![0].id ?? 0;
    Response response = await customerListRepo.fetchRequestInfoList(
        offset.value, storeId, search.value);

    if (response.statusCode == 200) {
      dynamic data = response.body['data'];
      dataList.clear();
      dataList.addAll(data
          .map<UserFollow>((element) => UserFollow.fromJson(element))
          .toList());
      if (search.value == "" || search.value == null) {
        dataList.clear();
      }
    }

    isLoading.value = false;
  }

  Future<void> fetchAllStoreDataReq() async {
    int storeId = Get.find<AuthController>().profileModel!.stores![0].id ?? 0;
    if (offsetReq.value == 1) {
      isLoadingReq.value = true;
      dataListRecieved.clear();
    }
    int type = 1;
    Response response = await customerListRepo.getAllRequestList(
        offsetReq.value, 0, type, storeId, search.value);
    if (response.statusCode == 200) {
      print(
          "===============================================================================>");
      print(response.body);
      print(
          "===============================================================================<");
      dataListRecieved.clear();
      dataListRecieved.addAll(response.body['data']
          .map<Follower>((element) => Follower.fromJson(element))
          .toList());
    } else {}

    isLoadingReq.value = false;
  }

  Future<void> fetchAllStoreDataAccept() async {
    int storeId = Get.find<AuthController>().profileModel!.stores![0].id ?? 0;
    if (offsetAccepted.value == 1) {
      isLoadingAccept.value = true;
      dataListAccepted.clear();
    }
    int type = 1;
    Response response = await customerListRepo.getAllRequestList(
        offsetReq.value, 1, type, storeId, search);
    if (response.statusCode == 200) {
      print(
          "===============================================================================>");
      print(response.body);
      print(
          "===============================================================================<");
      dataListAccepted.clear();
      dataListAccepted.addAll(response.body['data']
          .map<Follower>((element) => Follower.fromJson(element))
          .toList());
    } else {}

    isLoadingAccept.value = false;
  }

  Future<void> loadMoreAccept() async {
    offsetAccepted.value++;
    fetchAllStoreDataAccept();
  }

  Future<void> loadMore() async {
    offset.value++;
    fetchCustomersList();
  }

  Future<void> followUser(UserFollow user, int index) async {
    int storeId = Get.find<AuthController>().profileModel!.stores![0].id ?? 0;
    int userId = user.id ?? 0;
    Response response = await customerListRepo.followCustomer(userId, storeId);

    if (response.statusCode == 200) {
      print("Followed");
      print(response.body['data']);
      dataList.value[index].isFollowed = 1;
    }
    print(storeId);
  }

  Future<void> unfollowUser(UserFollow user, int index) async {
    int storeId = Get.find<AuthController>().profileModel!.stores![0].id ?? 0;
    int userId = user.id ?? 0;
    Response response =
        await customerListRepo.unfollowCustomer(userId, storeId);
    if (response.statusCode == 200) {
      print("UnFollowed");
      print(response.body['data']);
      dataList.value[index].isFollowed = 0;
    }
    print(storeId);
  }

  Future<void> unfollowUserForFollowerModel(
      int? userId, int index, bool isreq) async {
    int storeId = Get.find<AuthController>().profileModel!.stores![0].id ?? 0;
    Response response = await customerListRepo.unfollowUser(userId, storeId);
    Map<String, dynamic> body = response.body;
    if (body['status']) {
      if (isreq) {
        dataListRecieved.removeAt(index);
      } else {
        dataListAccepted.removeAt(index);
      }
      update();
    }
  }

  Future<void> acceptReq(int? userId, int index, bool isreq) async {
    int storeId = Get.find<AuthController>().profileModel!.stores![0].id ?? 0;
    Response response = await customerListRepo.accept(userId, storeId);
    Map<String, dynamic> body = response.body;
    if (body['status']) {
      if (isreq) {
        dataListRecieved.removeAt(index);
      } else {
        dataListAccepted.removeAt(index);
      }
      update();
    }
  }
}

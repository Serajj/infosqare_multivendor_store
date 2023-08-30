import 'package:sixam_mart_store/data/api/api_checker.dart';
import 'package:sixam_mart_store/data/api/api_client.dart';
import 'package:sixam_mart_store/data/model/response/customer_list_model.dart';
import 'package:sixam_mart_store/data/repository/customer_list_repo.dart';
import 'package:get/get.dart';

import '../data/model/response/user_follow_model.dart';
import 'auth_controller.dart';
import 'store_controller.dart';

class CustomerListController extends GetxController {
  RxInt offset = 1.obs;
  CustomerListRepo customerListRepo = CustomerListRepo(apiClient: Get.find());

  CustomerListController() {}

  List<CustomerModel>? _customerList;
  RxList<UserFollow> dataList = <UserFollow>[].obs;

  List<CustomerModel>? get customerList => _customerList;
  RxBool isLoading = true.obs;

  Future<void> fetchCustomersList() async {
    if (offset.value == 0) {
      isLoading.value = true;
    }
    int storeId = Get.find<AuthController>().profileModel!.stores![0].id ?? 0;
    Response response =
        await customerListRepo.fetchRequestInfoList(offset.value, storeId);

    if (response.statusCode == 200) {
      dataList.addAll(response.body['data']['data']
          .map<UserFollow>((element) => UserFollow.fromJson(element))
          .toList());
    }

    isLoading.value = false;
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
}

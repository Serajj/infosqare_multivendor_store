import 'package:sixam_mart_store/data/api/api_checker.dart';
import 'package:sixam_mart_store/data/api/api_client.dart';
import 'package:sixam_mart_store/data/model/response/customer_list_model.dart';
import 'package:sixam_mart_store/data/repository/customer_list_repo.dart';
import 'package:get/get.dart';

class CustomerListController extends GetxController implements GetxService {
  final CustomerListRepo customerListRepo;
  CustomerListController({required this.customerListRepo});

  String? _offset;
  List<String> _offsetList = [];
  bool _paginate = false;
  int? _pageSize;
  bool _isLoading = false;
  List<CustomerModel>? _customerList;

  List<CustomerModel>? get customerList => _customerList;
  bool get isLoading => _isLoading;

  Future<void> getCustomerList(String offset) async {
    print("API CALLING GET CUSTOMERLIST");
    if(offset == '1') {
      _offsetList = [];
      _offset = "1";
      _customerList = null;
      update();
    }
    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      Response response = await customerListRepo.fetchRequestInfoList(offset);
      print("customerList APi Response $response");
      if (response.statusCode == 200) {
        if (offset == '1') {
          _customerList = [];
        }
        _customerList!.addAll(PaginationCustomerModel.fromJson(response.body).data.data);
        _pageSize = PaginationCustomerModel.fromJson(response.body).totalSize;
        _isLoading = false;
        update();
      } else {
        ApiChecker.checkApi(response);
      }
    } else {
      if(isLoading) {
        _isLoading = false;
        update();
      }
    }
  }
}

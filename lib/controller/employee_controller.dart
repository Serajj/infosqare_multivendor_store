import 'dart:convert';

import 'package:connectuz_store/data/api/api_checker.dart';
import 'package:connectuz_store/data/model/response/delivery_man_model.dart';
import 'package:connectuz_store/data/model/response/employee_model.dart';
import 'package:connectuz_store/data/model/response/review_model.dart';
import 'package:connectuz_store/data/repository/delivery_man_repo.dart';
import 'package:connectuz_store/data/repository/employee_repo.dart';
import 'package:connectuz_store/view/base/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:win32/win32.dart';

class EmployeeController extends GetxController implements GetxService {
  final EmployeeRepo deliveryManRepo;
  EmployeeController({required this.deliveryManRepo});

  List<Employee>? _deliveryManList;
  List<Role> _roles = [];
  Role? _selectedRole;
  XFile? _pickedImage;
  List<XFile> _pickedIdentities = [];
  final List<String> _identityTypeList = [
    'staff',
    'manager',
    'helper'
  ]; //['passport', 'driving_license', 'nid'];
  int _identityTypeIndex = 0;
  bool _isLoading = false;
  List<ReviewModel>? _dmReviewList;
  bool _isSuspended = false;

  List<Employee>? get deliveryManList => _deliveryManList;
  List<Role> get employeeRoles => _roles;
  Role? get selectedRole => _selectedRole;

  XFile? get pickedImage => _pickedImage;
  List<XFile> get pickedIdentities => _pickedIdentities;
  List<String> get identityTypeList => _identityTypeList;
  int get identityTypeIndex => _identityTypeIndex;
  bool get isLoading => _isLoading;
  List<ReviewModel>? get dmReviewList => _dmReviewList;
  bool get isSuspended => _isSuspended;

  Future<void> getDeliveryManList() async {
    _deliveryManList = [];
    Response response = await deliveryManRepo.getDeliveryManList();
    if (response.statusCode == 200) {
      _deliveryManList = [];
      response.body.forEach((deliveryMan) =>
          _deliveryManList!.add(Employee.fromJson(deliveryMan)));
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getEmployeeRole() async {
    Response response = await deliveryManRepo.getEmployeeRole();
    if (response.statusCode == 200) {
      _roles = [];
      response.body
          .forEach((deliveryMan) => _roles.add(Role.fromJson(deliveryMan)));
    } else {
      _roles = [];
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> addDeliveryMan(
      Employee deliveryMan, String pass, String token, bool isAdd) async {
    _isLoading = true;
    update();
    Response response = await deliveryManRepo.addDeliveryMan(
        deliveryMan, pass, _pickedImage, _pickedIdentities, token, isAdd);
    if (response.statusCode == 200) {
      Get.back();
      showCustomSnackBar(
          isAdd
              ? 'Employee added successfully!'.tr
              : 'Employee updated successfully!'.tr,
          isError: false);
      getDeliveryManList();
    } else if (response.statusCode == 403) {
      String responseString = await response.body.bytesToString();
      print(responseString);
      displayErrorMessages(responseString);
      _isLoading = false;
    } else {
      ApiChecker.checkApi(response, password: true);
    }
    _isLoading = false;
    update();
  }

  void displayErrorMessages(String jsonResponse) {
    try {
      Map<String, dynamic> responseMap = json.decode(jsonResponse);

      if (responseMap.containsKey('errors')) {
        List<dynamic> errors = responseMap['errors'];
        for (var error in errors) {
          String errorMessage = error['message'];
          showCustomSnackBar(errorMessage);
        }
      }
    } catch (e) {
      print('Error parsing JSON: $e');
    }
  }

  Future<void> deleteDeliveryMan(int? deliveryManID) async {
    _isLoading = true;
    update();
    Response response = await deliveryManRepo.deleteDeliveryMan(deliveryManID);
    if (response.statusCode == 200) {
      Get.back();
      showCustomSnackBar('Employee deleted successfully'.tr, isError: false);
      getDeliveryManList();
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  void setSuspended(bool isSuspended) {
    _isSuspended = isSuspended;
  }

  void toggleSuspension(int? deliveryManID) async {
    _isLoading = true;
    update();
    Response response = await deliveryManRepo.updateDeliveryManStatus(
        deliveryManID, _isSuspended ? 1 : 0);
    if (response.statusCode == 200) {
      Get.back();
      getDeliveryManList();
      showCustomSnackBar(
        _isSuspended
            ? 'delivery_man_unsuspended_successfully'.tr
            : 'delivery_man_suspended_successfully'.tr,
        isError: false,
      );
      _isSuspended = !_isSuspended;
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<void> getDeliveryManReviewList(int? deliveryManID) async {
    _dmReviewList = null;
    Response response =
        await deliveryManRepo.getDeliveryManReviews(deliveryManID);
    if (response.statusCode == 200) {
      _dmReviewList = [];
      response.body['reviews'].forEach(
          (review) => _dmReviewList!.add(ReviewModel.fromJson(review)));
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void setIdentityTypeIndex(Role? identityType, bool notify) {
    _identityTypeIndex = identityType?.id ?? 0;
    _selectedRole = identityType;
    if (notify) {
      update();
    }
  }

  void pickImage(bool isLogo, bool isRemove) async {
    if (isRemove) {
      _pickedImage = null;
      _pickedIdentities = [];
    } else {
      if (isLogo) {
        XFile? picked =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (picked != null) {
          _pickedImage = picked;
        }
      } else {
        XFile? xFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (xFile != null) {
          _pickedIdentities.add(xFile);
        }
      }
      update();
    }
  }

  void removeIdentityImage(int index) {
    _pickedIdentities.removeAt(index);
    update();
  }
}

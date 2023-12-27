import 'dart:convert';

import 'package:connectuz_store/data/api/api_checker.dart';
import 'package:connectuz_store/data/model/response/delivery_man_model.dart';
import 'package:connectuz_store/data/model/response/review_model.dart';
import 'package:connectuz_store/data/repository/delivery_man_repo.dart';
import 'package:connectuz_store/view/base/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DeliveryManController extends GetxController implements GetxService {
  final DeliveryManRepo deliveryManRepo;
  DeliveryManController({required this.deliveryManRepo});

  List<DeliveryManModel>? _deliveryManList;
  XFile? _pickedImage;
  List<XFile> _pickedIdentities = [];
  final List<String> _identityTypeList = ['passport', 'driving_license', 'nid'];
  int _identityTypeIndex = 0;
  bool _isLoading = false;
  List<ReviewModel>? _dmReviewList;
  bool _isSuspended = false;

  List<DeliveryManModel>? get deliveryManList => _deliveryManList;
  XFile? get pickedImage => _pickedImage;
  List<XFile> get pickedIdentities => _pickedIdentities;
  List<String> get identityTypeList => _identityTypeList;
  int get identityTypeIndex => _identityTypeIndex;
  bool get isLoading => _isLoading;
  List<ReviewModel>? get dmReviewList => _dmReviewList;
  bool get isSuspended => _isSuspended;

  Future<void> getDeliveryManList() async {
    Response response = await deliveryManRepo.getDeliveryManList();
    if (response.statusCode == 200) {
      _deliveryManList = [];
      response.body.forEach((deliveryMan) =>
          _deliveryManList!.add(DeliveryManModel.fromJson(deliveryMan)));
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> addDeliveryMan(DeliveryManModel deliveryMan, String pass,
      String token, bool isAdd) async {
    _isLoading = true;
    update();
    Response response = await deliveryManRepo.addDeliveryMan(
        deliveryMan, pass, _pickedImage, _pickedIdentities, token, isAdd);
    print("=========> $response");
    if (response.statusCode == 200) {
      Get.back();
      showCustomSnackBar(
          isAdd
              ? 'delivery_man_added_successfully'.tr
              : 'delivery_man_updated_successfully'.tr,
          isError: false);
      getDeliveryManList();
      print("delivery response");
    } else if (response.statusCode == 403) {
      String responseString = await response.body.bytesToString();
      print(responseString);
      displayErrorMessages(responseString);
      _isLoading = false;
    } else {
      ApiChecker.checkApi(response, password: true);
      print("api checker $response");
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
      showCustomSnackBar('delivery_man_deleted_successfully'.tr,
          isError: false);
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

  void setIdentityTypeIndex(String? identityType, bool notify) {
    int index0 = 0;
    for (int index = 0; index < _identityTypeList.length; index++) {
      if (_identityTypeList[index] == identityType) {
        index0 = index;
        break;
      }
    }
    _identityTypeIndex = index0;
    if (notify) {
      update();
    }
  }

  void pickImage(bool isLogo, bool isRemove) async {
    try {
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
    } catch (e) {
      showCustomSnackBar(
          'Something went wrong , try again witn diffrent image'.tr);
    }
  }

  void removeIdentityImage(int index) {
    _pickedIdentities.removeAt(index);
    update();
  }
}

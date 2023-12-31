import 'package:connectuz_store/helper/route_helper.dart';
import 'package:get/get.dart';

import '../data/api/api_checker.dart';
import '../data/model/response/manual_payment.dart';
import '../data/model/response/membership_model.dart';
import '../data/repository/membership_repo.dart';
import 'package:universal_html/html.dart' as html;

class MembershipController extends GetxController implements GetxService {
  final MembershipRepo membershipRepo;
  MembershipController({required this.membershipRepo});
  RxList<Membership> dataList = <Membership>[].obs;
  Rx<Membership> selectedMembership = Membership().obs;
  Rx<Membership> currentMembership = Membership().obs;
  Rx<ManualPayment> manualPayment = ManualPayment().obs;
  RxString membershipId = "0".obs;

  Future<void> getMembershipList() async {
    Response response = await membershipRepo.getMembershipList();
    if (response.statusCode == 200) {
      var result = response.body['data'];
      dataList.clear();
      dataList.addAll(result
          .map<Membership>((element) => Membership.fromJson(element))
          .toList());
      if (membershipId.value != "0") {
        setCurrentUserMembership(membershipId.value);
      }
    }
  }

  Future<void> getSubmittedStatus() async {
    Response response = await membershipRepo.getSubmittedStatus();
    if (response.statusCode == 200) {
      var result = response.body['data'];
      if (result != null) {
        print("Adding vaues");
        manualPayment.value = ManualPayment.fromJson(result);
      } else {
        manualPayment.value = ManualPayment();
      }
    }
  }

  void setSelectedmembership(Membership membership) {
    print("selecting membership");
    selectedMembership.value = membership;
  }

  Future<bool> purchaseMembership(
      String amount, String paymentMethod, String planId) async {
    Response response =
        await membershipRepo.purchaseMembership(amount, paymentMethod, planId);
    if (response.statusCode == 200) {
      String redirectUrl = response.body['redirect_link'];
      Get.back();
      if (GetPlatform.isWeb) {
        html.window.open(redirectUrl, "_self");
      } else {
        Get.toNamed(RouteHelper.getPaymentRoute('0', 0, '', 0, false, '',
            addFundUrl: redirectUrl, guestId: ''));
      }
    } else {
      ApiChecker.checkApi(response);
    }
    return true;
  }

  Future<bool> uploadPaymentReciept(
      String model_id, String amount, String desc, String image) async {
    String type = "credit";
    String model_name = "Membership";
    Response response = await membershipRepo.uploadReciept(
        model_id, model_name, type, desc, amount, image);
    if (response.statusCode == 200) {
      var result = response.body;
      if (result['status'].toString() == "true") {
        return true;
      }
    }
    return false;
  }

  void setCurrentUserMembership(String? membershipId) {
    print("Setting");
    currentMembership.value = dataList.firstWhere(
      (item) => item.id == int.tryParse(membershipId.toString()),
      orElse: () => Membership(), // Return null if the item is not found
    );
  }
}

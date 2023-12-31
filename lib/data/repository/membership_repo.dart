import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../helper/route_helper.dart';
import '../../util/app_constants.dart';
import '../api/api_client.dart';
import 'package:universal_html/html.dart' as html;

class MembershipRepo {
  final ApiClient apiClient;
  MembershipRepo({required this.apiClient});

  Future<Response> getMembershipList() async {
    return await apiClient.getData(AppConstants.membershipUri + '?type=store');
  }

  Future<Response> uploadReciept(String model_id, String model_name,
      String type, String desc, String amount, String image) async {
    return await apiClient.postData(AppConstants.uploadpaymentreceipt, {
      "model_id": model_id,
      "model_name": model_name,
      "type": type,
      "desc": desc,
      "amount": amount.toString(),
      "image": image
    });
  }

  Future<Response> getSubmittedStatus() async {
    return await apiClient.getData(AppConstants.getmanualPayment);
  }

  Future<Response> purchaseMembership(
      String amount, String paymentMethod, String planId) async {
    String? hostname = html.window.location.hostname;
    String protocol = html.window.location.protocol;

    return await apiClient.postData(AppConstants.addMembershipPurchaseUri, {
      "amount": amount,
      "planId": planId,
      "payment_method": paymentMethod,
      "payment_platform": GetPlatform.isWeb ? 'web' : '',
      "callback": '$protocol//$hostname${RouteHelper.membership}',
    });
  }
}

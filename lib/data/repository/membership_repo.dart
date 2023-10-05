import 'package:get/get_connect/http/src/response/response.dart';

import '../../util/app_constants.dart';
import '../api/api_client.dart';

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
}

import 'package:connectuz_store/controller/auth_controller.dart';
import 'package:connectuz_store/helper/route_helper.dart';
import 'package:connectuz_store/view/base/custom_snackbar.dart';
import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response, {bool password = false}) {
    if (response.statusCode == 401) {
      Get.find<AuthController>().clearSharedData();
      Get.offAllNamed(RouteHelper.getSignInRoute());
    } else {
      if (password) {
        showCustomSnackBar(
            "${response.statusText} Make sure entered password should contain AlphaNumeric characters and numbers.");
      } else {
        showCustomSnackBar(response.statusText);
      }
    }
  }
}

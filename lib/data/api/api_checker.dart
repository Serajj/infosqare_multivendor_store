import 'package:connectuz_store/controller/auth_controller.dart';
import 'package:connectuz_store/helper/route_helper.dart';
import 'package:connectuz_store/view/base/custom_snackbar.dart';
import 'package:connectuz_store/view/base/membership_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response,
      {bool password = false, BuildContext? context}) {
    if (response.statusCode == 401) {
      Get.find<AuthController>().clearSharedData();
      Get.offAllNamed(RouteHelper.getSignInRoute());
    } else {
      if (response.statusCode == 203) {
        print(response.body);
        var type = response.body['type'];
        var message = response.body['message'];
        showCustomSnackBar(message);
        if (type == "membership") {
          showDialog(
              context: context as BuildContext,
              builder: (ctx) => MembershipDialog(
                    icon: "",
                    description: "Subscribe a plan to confirm orders.",
                    title: "Go to subscriptions.",
                  ));
        }
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
}

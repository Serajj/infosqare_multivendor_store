import 'package:connectuz_store/controller/auth_controller.dart';
import 'package:connectuz_store/helper/route_helper.dart';
import 'package:connectuz_store/util/dimensions.dart';
import 'package:connectuz_store/util/images.dart';
import 'package:connectuz_store/util/styles.dart';
import 'package:connectuz_store/view/base/custom_app_bar.dart';
import 'package:connectuz_store/view/base/custom_button.dart';
import 'package:connectuz_store/view/base/custom_snackbar.dart';
import 'package:connectuz_store/view/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'forgot_password'.tr),
      body: SafeArea(
          child: Center(
              child: Scrollbar(
                  child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: Center(
            child: SizedBox(
                width: 1170,
                child: Column(children: [
                  Text('Please enter email or phone'.tr,
                      style: robotoRegular, textAlign: TextAlign.center),
                  const SizedBox(height: 50),
                  CustomTextField(
                    controller: _emailController,
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    hintText: 'email'.tr,
                    prefixIcon: Images.mail,
                    onSubmit: (text) =>
                        GetPlatform.isWeb ? _forgetPass() : null,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeLarge),
                  GetBuilder<AuthController>(builder: (authController) {
                    return !authController.isLoading
                        ? CustomButton(
                            buttonText: 'next'.tr,
                            onPressed: () => _forgetPass(),
                          )
                        : const Center(child: CircularProgressIndicator());
                  }),
                ]))),
      )))),
    );
  }

  void _forgetPass() {
    String email = _emailController.text.trim();
    if (email.isEmpty) {
      showCustomSnackBar('Enter email/Phone'.tr);
    }
    // else if (!GetUtils.isEmail(email)) {
    //   showCustomSnackBar('Enter'.tr);
    // }
    else {
      Get.find<AuthController>().forgetPassword(email).then((status) async {
        if (status.isSuccess) {
          Get.toNamed(RouteHelper.getVerificationRoute(email));
        } else {
          showCustomSnackBar(status.message);
        }
      });
    }
  }
}

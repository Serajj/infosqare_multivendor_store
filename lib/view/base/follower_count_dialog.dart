import 'package:sixam_mart_store/controller/auth_controller.dart';
import 'package:sixam_mart_store/controller/campaign_controller.dart';
import 'package:sixam_mart_store/controller/delivery_man_controller.dart';
import 'package:sixam_mart_store/controller/order_controller.dart';
import 'package:sixam_mart_store/controller/store_controller.dart';
import 'package:sixam_mart_store/util/dimensions.dart';
import 'package:sixam_mart_store/util/styles.dart';
import 'package:sixam_mart_store/view/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/route_helper.dart';

class FollowerCountDialog extends StatelessWidget {
  final String icon;
  final String? title;
  final String description;
  const FollowerCountDialog({
    Key? key,
    required this.icon,
    this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
          width: 500,
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              // Padding(
              //   padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              //   child: Image.asset(icon, width: 50, height: 50),
              // ),
              title != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeLarge),
                      child: Text(
                        title!,
                        textAlign: TextAlign.center,
                        style: robotoMedium.copyWith(
                            fontSize: Dimensions.fontSizeExtraLarge,
                            color: Colors.red),
                      ),
                    )
                  : const SizedBox(),
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                child: Text(description,
                    style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              CustomButton(
                buttonText: "Follow Now",
                onPressed: () {
                  Get.toNamed(RouteHelper.getCustomerRequest());
                },
              )
            ]),
          )),
    );
  }
}

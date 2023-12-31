import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/dimensions.dart';
import '../../util/images.dart';
import '../../util/styles.dart';

class FundPaymentDialog extends StatelessWidget {
  const FundPaymentDialog({Key? key}) : super(key: key);

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
            Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              child: Image.asset(Images.warning, width: 70, height: 70),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeLarge),
              child: Text(
                'Do you want to cancel this transaction ?'.tr,
                textAlign: TextAlign.center,
                style: robotoMedium.copyWith(
                    fontSize: Dimensions.fontSizeExtraLarge, color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                if (Get.isDialogOpen!) {
                  Get.back();
                }
                Get.back();
                // Get.offAllNamed(RouteHelper.getInitialRoute());
              },
              style: TextButton.styleFrom(
                backgroundColor:
                    Theme.of(context).disabledColor.withOpacity(0.3),
                minimumSize: const Size(1170, 40),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusSmall)),
              ),
              child: Text('Cancel transaction'.tr,
                  textAlign: TextAlign.center,
                  style: robotoBold.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color)),
            ),
          ]),
        ),
      ),
    );
  }
}

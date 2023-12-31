import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/order_controller.dart';
import '../../util/dimensions.dart';
import '../../util/images.dart';
import '../../util/styles.dart';
import 'custom_button.dart';

class PaymentFailedDialog extends StatelessWidget {
  final String? orderID;
  final String? orderType;
  final double? orderAmount;
  final double? maxCodOrderAmount;
  final bool? isCashOnDelivery;
  const PaymentFailedDialog(
      {Key? key,
      required this.orderID,
      required this.maxCodOrderAmount,
      required this.orderAmount,
      required this.orderType,
      required this.isCashOnDelivery})
      : super(key: key);

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
                  'are_you_agree_with_this_order_fail'.tr,
                  textAlign: TextAlign.center,
                  style: robotoMedium.copyWith(
                      fontSize: Dimensions.fontSizeExtraLarge,
                      color: Colors.red),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                child: Text(
                  'if_you_do_not_pay'.tr,
                  style:
                      robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              GetBuilder<OrderController>(builder: (orderController) {
                return !orderController.isLoading
                    ? Column(children: [])
                    : const Center(child: CircularProgressIndicator());
              }),
            ]),
          )),
    );
  }
}

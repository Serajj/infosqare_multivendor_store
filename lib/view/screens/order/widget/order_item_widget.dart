import 'package:connectuz_store/controller/order_controller.dart';
import 'package:connectuz_store/controller/splash_controller.dart';
import 'package:connectuz_store/data/model/response/order_details_model.dart';
import 'package:connectuz_store/data/model/response/order_model.dart';
import 'package:connectuz_store/helper/price_converter.dart';
import 'package:connectuz_store/util/dimensions.dart';
import 'package:connectuz_store/util/styles.dart';
import 'package:connectuz_store/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderModel? order;
  final OrderDetailsModel orderDetails;
  const OrderItemWidget(
      {Key? key, required this.order, required this.orderDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String addOnText = Get.find<OrderController>().getAddOnText(orderDetails);
    String variationText =
        Get.find<OrderController>().getVariationText(orderDetails);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          child: CustomImage(
            height: 50,
            width: 50,
            fit: BoxFit.cover,
            image:
                '${order!.itemCampaign == 1 ? Get.find<SplashController>().configModel!.baseUrls!.campaignImageUrl : Get.find<SplashController>().configModel!.baseUrls!.itemImageUrl}/${orderDetails.itemDetails!.image}',
          ),
        ),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(
                  child: Text(
                orderDetails.itemDetails!.name!,
                style:
                    robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
              Text('${'quantity'.tr}:',
                  style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall)),
              Text(
                orderDetails.quantity.toString(),
                style: robotoMedium.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: Dimensions.fontSizeSmall),
              ),
            ]),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Row(children: [
              Expanded(
                  child: Text(
                PriceConverter.convertPrice(orderDetails.price),
                style: robotoMedium,
              )),
              ((Get.find<SplashController>()
                              .configModel!
                              .moduleConfig!
                              .module!
                              .unit! &&
                          orderDetails.itemDetails!.unitType != null) ||
                      (Get.find<SplashController>()
                              .configModel!
                              .moduleConfig!
                              .module!
                              .vegNonVeg! &&
                          Get.find<SplashController>()
                              .configModel!
                              .toggleVegNonVeg!))
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeExtraSmall,
                          horizontal: Dimensions.paddingSizeSmall),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSmall),
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                      ),
                      child: Text(
                        Get.find<SplashController>()
                                .configModel!
                                .moduleConfig!
                                .module!
                                .unit!
                            ? orderDetails.itemDetails!.unitType ?? ''
                            : orderDetails.itemDetails!.veg == 0
                                ? 'non_veg'.tr
                                : 'veg'.tr,
                        style: robotoMedium.copyWith(
                            fontSize: Dimensions.fontSizeExtraSmall,
                            color: Theme.of(context).primaryColor),
                      ),
                    )
                  : const SizedBox(),
            ]),
          ]),
        ),
      ]),
      addOnText.isNotEmpty
          ? Padding(
              padding:
                  const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
              child: Row(children: [
                const SizedBox(width: 60),
                Text('${'addons'.tr}: ',
                    style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall)),
                Flexible(
                    child: Text(addOnText,
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).disabledColor,
                        ))),
              ]),
            )
          : const SizedBox(),
      variationText.isNotEmpty
          ? Padding(
              padding:
                  const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
              child: Row(children: [
                const SizedBox(width: 60),
                Text('${'variations'.tr}: ',
                    style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall)),
                Flexible(
                    child: Text(variationText,
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).disabledColor,
                        ))),
              ]),
            )
          : const SizedBox(),
      const Divider(height: Dimensions.paddingSizeLarge),
      const SizedBox(height: Dimensions.paddingSizeSmall),
    ]);
  }
}

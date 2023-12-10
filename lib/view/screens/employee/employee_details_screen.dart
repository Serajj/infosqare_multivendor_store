import 'package:connectuz_store/controller/delivery_man_controller.dart';
import 'package:connectuz_store/controller/employee_controller.dart';
import 'package:connectuz_store/controller/splash_controller.dart';
import 'package:connectuz_store/data/model/response/delivery_man_model.dart';
import 'package:connectuz_store/data/model/response/employee_model.dart';
import 'package:connectuz_store/helper/price_converter.dart';
import 'package:connectuz_store/util/dimensions.dart';
import 'package:connectuz_store/util/images.dart';
import 'package:connectuz_store/util/styles.dart';
import 'package:connectuz_store/view/base/confirmation_dialog.dart';
import 'package:connectuz_store/view/base/custom_app_bar.dart';
import 'package:connectuz_store/view/base/custom_button.dart';
import 'package:connectuz_store/view/base/custom_image.dart';
import 'package:connectuz_store/view/screens/deliveryman/widget/amount_card_widget.dart';
import 'package:connectuz_store/view/screens/store/widget/review_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  final Employee deliveryMan;
  const EmployeeDetailsScreen({Key? key, required this.deliveryMan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<EmployeeController>()
        .setSuspended(!(deliveryMan.status == 0 ? true : false));
    // Get.find<EmployeeController>().getDeliveryManReviewList(deliveryMan.id);

    return Scaffold(
      appBar: CustomAppBar(title: 'Employee details'.tr),
      body: GetBuilder<DeliveryManController>(builder: (dmController) {
        return Column(children: [
          Expanded(
              child: SingleChildScrollView(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            physics: const BouncingScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color:
                            deliveryMan.status == 1 ? Colors.green : Colors.red,
                        width: 2),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                      child: CustomImage(
                    image:
                        '${Get.find<SplashController>().configModel!.baseUrls!.deliveryManImageUrl}/${deliveryMan.image}',
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  )),
                ),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(
                        '${deliveryMan.fName} ${deliveryMan.lName}',
                        style: robotoMedium.copyWith(
                            fontSize: Dimensions.fontSizeLarge),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      Text(
                        deliveryMan.status == 1 ? 'online'.tr : 'offline'.tr,
                        style: robotoRegular.copyWith(
                          color: deliveryMan.status == 1
                              ? Colors.green
                              : Colors.red,
                          fontSize: Dimensions.fontSizeExtraSmall,
                        ),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    ])),
              ]),
              const SizedBox(height: Dimensions.paddingSizeLarge),
            ]),
          )),
          CustomButton(
            onPressed: () {
              Get.dialog(ConfirmationDialog(
                icon: Images.warning,
                description: dmController.isSuspended
                    ? 'are_you_sure_want_to_un_suspend_this_employee'.tr
                    : 'are_you_sure_want_to_suspend_this_employee'.tr,
                onYesPressed: () =>
                    dmController.toggleSuspension(deliveryMan.id),
              ));
            },
            buttonText: dmController.isSuspended
                ? 'un_suspend_this_employee'.tr
                : 'suspend_this_employee'.tr,
            margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            color: dmController.isSuspended ? Colors.green : Colors.red,
          ),
        ]);
      }),
    );
  }
}

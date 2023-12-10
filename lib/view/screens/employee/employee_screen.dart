import 'package:connectuz_store/controller/delivery_man_controller.dart';
import 'package:connectuz_store/controller/employee_controller.dart';
import 'package:connectuz_store/controller/splash_controller.dart';
import 'package:connectuz_store/data/model/response/delivery_man_model.dart';
import 'package:connectuz_store/data/model/response/employee_model.dart';
import 'package:connectuz_store/helper/route_helper.dart';
import 'package:connectuz_store/util/dimensions.dart';
import 'package:connectuz_store/util/images.dart';
import 'package:connectuz_store/util/styles.dart';
import 'package:connectuz_store/view/base/confirmation_dialog.dart';
import 'package:connectuz_store/view/base/custom_app_bar.dart';
import 'package:connectuz_store/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<EmployeeController>().getDeliveryManList();
    Get.find<EmployeeController>().getEmployeeRole();

    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: CustomAppBar(title: 'Your Employees'.tr),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(RouteHelper.getAddEmployeeRoute(null)),
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add_circle_outline,
            color: Theme.of(context).cardColor, size: 30),
      ),
      body: GetBuilder<EmployeeController>(builder: (dmController) {
        return dmController.deliveryManList != null
            ? dmController.deliveryManList!.isNotEmpty
                ? ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: dmController.deliveryManList!.length,
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    itemBuilder: (context, index) {
                      Employee deliveryMan =
                          dmController.deliveryManList![index];
                      return InkWell(
                        onTap: () {
                          // Get.toNamed(
                          // RouteHelper.getEmployeeDetailsRoute(deliveryMan))
                        },
                        child: Column(children: [
                          Row(children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: deliveryMan.status == 1
                                        ? Colors.green
                                        : Colors.red,
                                    width: 2),
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                  child: CustomImage(
                                image:
                                    '${Get.find<SplashController>().configModel!.baseUrls!.employeeImageUrl}/${deliveryMan.image ?? ''}',
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              )),
                            ),
                            const SizedBox(width: Dimensions.paddingSizeSmall),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${deliveryMan.fName} ${deliveryMan.lName}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: robotoMedium,
                                ),
                                Text(
                                  '${deliveryMan.role?.name}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            )),
                            const SizedBox(width: Dimensions.paddingSizeSmall),
                            IconButton(
                              onPressed: () => Get.toNamed(
                                  RouteHelper.getAddEmployeeRoute(deliveryMan)),
                              icon: const Icon(Icons.edit, color: Colors.blue),
                            ),
                            IconButton(
                              onPressed: () {
                                Get.dialog(ConfirmationDialog(
                                  icon: Images.warning,
                                  description:
                                      'are_you_sure_want_to_delete_this_delivery_man'
                                          .tr,
                                  onYesPressed: () =>
                                      Get.find<EmployeeController>()
                                          .deleteDeliveryMan(deliveryMan.id),
                                ));
                              },
                              icon: const Icon(Icons.delete_forever,
                                  color: Colors.red),
                            ),
                          ]),
                          Padding(
                            padding: const EdgeInsets.only(left: 60),
                            child: Divider(
                              color: index ==
                                      dmController.deliveryManList!.length - 1
                                  ? Colors.transparent
                                  : Theme.of(context).disabledColor,
                            ),
                          ),
                        ]),
                      );
                    },
                  )
                : Center(child: Text('no_delivery_man_found'.tr))
            : const Center(child: CircularProgressIndicator());
      }),
    );
  }
}

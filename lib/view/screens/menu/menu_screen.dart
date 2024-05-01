import 'package:connectuz_store/controller/auth_controller.dart';
import 'package:connectuz_store/controller/splash_controller.dart';
import 'package:connectuz_store/data/model/response/menu_model.dart';
import 'package:connectuz_store/helper/route_helper.dart';
import 'package:connectuz_store/util/dimensions.dart';
import 'package:connectuz_store/util/images.dart';
import 'package:connectuz_store/view/screens/menu/widget/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MenuModel> menuList = [];

    menuList.add(MenuModel(
        icon: '', title: 'profile'.tr, route: RouteHelper.getProfileRoute()));

    if (Get.find<AuthController>().modulePermission!.item!) {
      menuList.add(MenuModel(
        icon: Images.addFood,
        title: 'add_item'.tr,
        route: RouteHelper.getItemRoute(null),
        isBlocked:
            !Get.find<AuthController>().profileModel!.stores![0].itemSection!,
      ));
    }
    if (Get.find<AuthController>().modulePermission!.item!) {
      menuList.add(MenuModel(
          icon: Images.categories,
          title: 'categories'.tr,
          route: RouteHelper.getCategoriesRoute()));
    }
    if (Get.find<AuthController>().modulePermission!.bankInfo!) {
      menuList.add(MenuModel(
          icon: Images.creditCard,
          title: 'bank_info'.tr,
          route: RouteHelper.getBankInfoRoute()));
    }
    if (Get.find<AuthController>().modulePermission!.campaign!) {
      menuList.add(MenuModel(
          icon: Images.campaign,
          title: 'campaign'.tr,
          route: RouteHelper.getCampaignRoute()));
    }
    // Get.find<AuthController>()
    //             .profileModel!
    //             .stores![0]
    //             .selfDeliverySystem ==
    //         1 &&
    if (Get.find<AuthController>().getUserType() == 'owner') {
      menuList.add(MenuModel(
          icon: Images.deliveryMan,
          title: 'delivery_man'.tr,
          route: RouteHelper.getDeliveryManRoute()));
    }
    if (Get.find<SplashController>()
            .configModel!
            .moduleConfig!
            .module!
            .addOn! &&
        Get.find<AuthController>().modulePermission!.addon!) {
      menuList.add(MenuModel(
          icon: Images.addon,
          title: 'addons'.tr,
          route: RouteHelper.getAddonsRoute()));
    }
    if (Get.find<AuthController>().modulePermission!.employee! &&
        Get.find<AuthController>().getUserType() == 'owner') {
      menuList.add(MenuModel(
          icon: Images.addon,
          title: 'Employee'.tr,
          route: RouteHelper.employee));
    }
    if (Get.find<AuthController>().modulePermission!.chat!) {
      menuList.add(MenuModel(
          icon: Images.chat,
          title: 'conversation'.tr,
          route: RouteHelper.getConversationListRoute()));
    }
    menuList.add(MenuModel(
        icon: Images.language,
        title: 'language'.tr,
        route: RouteHelper.getLanguageRoute('menu')));
    menuList.add(MenuModel(
        icon: Images.maintenance,
        title: 'Requests'.tr,
        route: RouteHelper.getCustomerRequest()));
    menuList.add(MenuModel(
        icon: Images.categories,
        title: 'Subscription'.tr,
        route: RouteHelper.getMembershipRoute()));
    menuList.add(MenuModel(
        icon: Images.coupon,
        title: 'coupon'.tr,
        route: RouteHelper.getCouponRoute()));
    menuList.add(MenuModel(
        icon: Images.expense,
        title: 'expense_report'.tr,
        route: RouteHelper.getExpenseRoute()));

    menuList.add(MenuModel(
        icon: Images.support,
        title: 'WhatsApp Support',
        onTap: () async {
          String message = "Hi connectuz";
          String url =
              "https://wa.me/919063447157?text=${Uri.encodeFull(message)}";

          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
        route: RouteHelper.getExpenseRoute()));

    menuList.add(MenuModel(
        icon: Images.restaurantCover,
        title: 'Refer',
        onTap: () {
          String msgToShare = '''Hey ! Sharing is caring .

I have launched my Online Store in Connectuz Store & accepting orders online .

Are you are looking to launch your first online store for your business ?

Check out this App & enjoy amazing features .

Happy online store @ Connectuz 

Download App from playstore ⬇️

https://play.google.com/store/apps/details?id=com.connectuz.store

Checkout YouTube link on how to set up your store account :

https://youtu.be/LWTMuf4i2Jg ''';
          Share.share(msgToShare);
        },
        route: RouteHelper.getExpenseRoute()));

    menuList.add(MenuModel(
        icon: Images.call,
        title: 'Contact Us',
        onTap: () async {
          String url = 'tel:+919063447157';

          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
        route: RouteHelper.getExpenseRoute()));

    menuList.add(MenuModel(
        icon: Images.policy,
        title: 'privacy_policy'.tr,
        route: RouteHelper.getPrivacyRoute()));
    menuList.add(MenuModel(
        icon: Images.terms,
        title: 'terms_condition'.tr,
        route: RouteHelper.getTermsRoute()));
    menuList.add(MenuModel(icon: Images.logOut, title: 'logout'.tr, route: ''));

    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
            top: Radius.circular(Dimensions.radiusExtraLarge)),
        color: Theme.of(context).cardColor,
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.keyboard_arrow_down_rounded, size: 30),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: (1 / 1.2),
            crossAxisSpacing: Dimensions.paddingSizeExtraSmall,
            mainAxisSpacing: Dimensions.paddingSizeExtraSmall,
          ),
          itemCount: menuList.length,
          itemBuilder: (context, index) {
            return MenuButton(
                menu: menuList[index],
                isProfile: index == 0,
                onTap: menuList[index].onTap,
                isLogout: index == menuList.length - 1);
          },
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),
      ]),
    );
  }
}

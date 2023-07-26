import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart_store/controller/request_controller.dart';
import 'package:sixam_mart_store/data/model/body/request_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sixam_mart_store/data/repository/request_repo.dart';
import 'package:sixam_mart_store/util/dimensions.dart';
import 'package:sixam_mart_store/view/base/custom_app_bar.dart';
import 'package:sixam_mart_store/view/screens/store_requests/widget/button_widget.dart';

class FollowScreen extends StatefulWidget {
  @override
  _FollowScreenState createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen> {
  //FriendRequest? get request => null;

  @override
  void initState() {
    super.initState();
    Get.find<RequestController>().fetchRequestedUsers(
        1); // Fetch the user list when the screen initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Requests'.tr),
      endDrawerEnableOpenDragGesture: false,
      backgroundColor: Theme.of(context).cardColor,
      key: UniqueKey(),
      body: GetBuilder<RequestController>(
        builder: (requestController) {
          return ListView.builder(
            itemCount: requestController.requestedUsers!.length,
            itemBuilder: (context, index) {
              
            });
        },
      ),
    );
  }
}

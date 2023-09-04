import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart_store/view/screens/user_request/follow_screen.dart';
import 'package:sixam_mart_store/view/screens/user_request/following_and_followed_screen.dart';
import 'package:sixam_mart_store/view/screens/user_request/request_tab_screen.dart';

import '../../../controller/customer_list_controller.dart';

class UserRequest extends StatefulWidget {
  const UserRequest({Key? key}) : super(key: key);

  @override
  State<UserRequest> createState() => _UserRequestState();
}

class _UserRequestState extends State<UserRequest> {
  CustomerListController customerListController =
      Get.put(CustomerListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            title: Text('Customers'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'All Customers'),
                Tab(text: 'Request'),
                Tab(text: 'Accepted'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              FollowScreen(),
              RequestTabScreen(),
              FollowingAndFollowedScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

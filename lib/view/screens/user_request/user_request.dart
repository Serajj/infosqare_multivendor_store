import 'package:flutter/material.dart';
import 'package:sixam_mart_store/view/screens/user_request/follow_screen.dart';
import 'package:sixam_mart_store/view/screens/user_request/following_and_followed_screen.dart';
import 'package:sixam_mart_store/view/screens/user_request/request_tab_screen.dart';

class UserRequest extends StatelessWidget {
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

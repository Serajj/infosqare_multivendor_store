import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:connectuz_store/view/screens/user_request/design_model.dart';

class FollowController extends GetxController {
  final ValueNotifier<List<User>> _usersNotifier = ValueNotifier([]);

  ValueListenable<List<User>> get users => _usersNotifier;

  void fetchUsers() async {
    String jsonData = await rootBundle.loadString('assets/users.json');

    List<dynamic> usersData = jsonDecode(jsonData);

    List<User> users =
        usersData.map((userData) => User.fromJson(userData)).toList();

    _usersNotifier.value = users;
  }

  bool isFollowingUser(User user) {
    // Implement your logic to check if the user is already followed
    // Return true if the user is followed, false otherwise
    return false;
  }

  void followUser(User user) {
    // Implement your logic to follow the user
    // Add the necessary code to update the follow status in the database or perform any required actions
  }

  void unfollowUser(User user) {
    // Implement your logic to unfollow the user
    // Add the necessary code to update the unfollow status in the database or perform any required actions
  }
}

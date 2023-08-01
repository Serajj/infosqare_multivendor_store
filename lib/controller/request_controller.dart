/*import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sixam_mart_store/data/model/response/userRequest_model.dart';
import 'package:sixam_mart_store/data/repository/request_repo.dart';

class RequestController extends GetxController {
  
  final RequestRepo requestRepo;
  RequestController({required this.requestRepo});
  
  //List<int> _offsetList = [];
  int _offset = 1;
  List<UserData>? requestedUsers;
  

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchRequestedUsers(_offset);
  }

    fetchRequestedUsers(int offset) async{
    Response response = await requestRepo.fetchRequestInfoList(offset);
    var jsondata = json.decode(response.body);
    return (jsondata['data'] as List).map((e) => UserData.fromJson(e)).toList();
  }

   /* Future<void> getPaginatedOrders(int offset, bool reload) async {
    if(offset == 1 || reload) {
      _offsetList = [];
      _offset = 1;
      update();
    }
    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
    Response response = await requestRepo.fetchRequestInfoList(offset);
      if (response.statusCode == 200) {
        previouslyRequested!.addAll(RequestModel.fromJson(response.body).data as Iterable<Data>);
        _pageSize = PaginatedOrderModel.fromJson(response.body).totalSize;
        _paginate = false;
        update();
      } else {
        ApiChecker.checkApi(response);
      }
    } else {
      if(_paginate) {
        _paginate = false;
        update();
      }
    }
  }*/

}*/

/*import 'dart:convert';
import 'package:flutter/services.dart'; 

import 'package:flutter/foundation.dart';
import 'package:sixam_mart_store/data/model/body/request_model.dart';

/*enum RequestStatus {
  pending,
  accepted,
  following,
}*/

class FollowController {

  List<User> userData = [];

  final ValueNotifier<List<User>> _usersNotifier = ValueNotifier([]);

  ValueListenable<List<User>> get users => _usersNotifier;

  //get status => null;


    Future<void> fetchUsers() async {
    final jsonData = await rootBundle.loadString('assets/users.json');

    List<dynamic> usersData = jsonDecode(jsonData);

    List<User> users = usersData.map((userData) => User.fromJson(userData)).toList();

    _usersNotifier.value = users;
  }
  
  Future<void> acceptFriendRequest(User request) async {
   //request.status = RequestStatus.accepted as String;
    // Perform necessary actions to accept the friend request
  }

  bool isFollowingUser(User user) {
    // Implement your logic to check if the user is already followed
    // Return true if the user is followed, false otherwise
    return false;
  }

  void followUser(User user) {
    // Implement your logic to follow the user
    // Add the necessary code to update the follow status in the database or perform any required actions
    //final friendRequest = _usersNotifier.firstWhere((request) => request.sender == user);
    //friendRequest.status = RequestStatus.following;
  }

  void unfollowUser(User user) {
    // Implement your logic to unfollow the user
    // Add the necessary code to update the unfollow status in the database or perform any required actions
  }

  void deleteUser(User user) {
    userData.remove(user);
  }
}*/
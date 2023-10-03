import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart_store/data/model/response/user_follow_model.dart';
import 'package:sixam_mart_store/view/base/custom_app_bar.dart';

import '../../../controller/customer_list_controller.dart';
import 'design_controller.dart';
import 'design_model.dart';

class FollowScreen extends StatefulWidget {
  FollowScreen({Key? key}) : super(key: key);
  @override
  _FollowScreenState createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen> {
  final TextEditingController _searchController = TextEditingController();
  CustomerListController customerListController = Get.find();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    print("Calling CustomerList API");
    customerListController
        .fetchCustomersList(); // Fetch the user list when the screen initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CustomerListController>(
        builder: (customerListController) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(31, 187, 183, 183),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          // Perform the search here
                        },
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) async {
                      customerListController.search.value = value;
                      print(value);
                      customerListController.fetchCustomersList();
                    },
                  ),
                ),
              ),
              Obx(() => customerListController.isLoading.isTrue
                  ? Center(child: CircularProgressIndicator())
                  : customerListController.dataList.length > 0
                      ? Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: scrollController,
                            itemCount: customerListController.dataList.length,
                            itemBuilder: (context, index) {
                              //final user = users[index];

                              if (index <
                                  customerListController.dataList.length) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://api.connectuz.com/public/assets/admini/img/160x160/img1.jpg"),
                                  ),
                                  title: Text(customerListController
                                      .dataList[index].text
                                      .toString()),
                                  subtitle: Text(customerListController
                                      .dataList[index].email
                                      .toString()),
                                  trailing: FollowButton(
                                    user:
                                        customerListController.dataList[index],
                                    controller: customerListController,
                                    index: index,
                                  ),
                                );
                              } else {
                                customerListController
                                    .loadMore(); // Load more data when reaching the end
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              }
                            },
                          ),
                        )
                      : Container(
                          child: Center(
                            child: Text("No users to show."),
                          ),
                        )),
            ],
          );
        },
      ),
    );
  }
}

class FollowButton extends StatefulWidget {
  final UserFollow user;
  final CustomerListController controller;
  final int index;

  FollowButton(
      {required this.user, required this.controller, required this.index});

  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  int isFollowing = 0;

  @override
  void initState() {
    super.initState();
    setIsFollwed(); // Check if the user is already followed
  }

  setIsFollwed() {
    isFollowing = widget.user.isFollowed ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (isFollowing == 0) {
          await widget.controller.followUser(widget.user, widget.index);
          setState(() {
            isFollowing = 1;
          });
        } else {
          await widget.controller.unfollowUser(widget.user, widget.index);
          setState(() {
            isFollowing = 0;
          });
        }
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            isFollowing == 0
                ? Theme.of(context).primaryColor
                : isFollowing == 1
                    ? Color.fromARGB(255, 253, 149, 12)
                    : Colors.red,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ))),
      child: Text(
        isFollowing == 0
            ? ' Follow '
            : isFollowing == 1
                ? 'Pending'
                : ' Confirm ',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

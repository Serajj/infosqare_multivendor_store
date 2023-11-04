import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectuz_store/view/screens/user_request/follow_button.dart';

import '../../../controller/customer_list_controller.dart';

class FollowingAndFollowedScreen extends StatefulWidget {
  const FollowingAndFollowedScreen({Key? key}) : super(key: key);

  @override
  _FollowingAndFollowedScreenState createState() =>
      _FollowingAndFollowedScreenState();
}

class _FollowingAndFollowedScreenState
    extends State<FollowingAndFollowedScreen> {
  final ScrollController scrollController = ScrollController();
  CustomerListController mcontroller = Get.find();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    mcontroller.fetchAllStoreDataAccept();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mcontroller.fetchAllStoreDataAccept();
        },
        child: Icon(
          Icons.refresh_rounded,
          color: Colors.white,
        ),
      ),
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
                      mcontroller.search.value = value;
                      print(value);
                      mcontroller.fetchAllStoreDataAccept();
                    },
                  ),
                ),
              ),
              Obx(() => customerListController.isLoadingAccept.isTrue
                  ? Center(child: CircularProgressIndicator())
                  : customerListController.dataListAccepted.length > 0
                      ? Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: scrollController,
                            itemCount:
                                customerListController.dataListAccepted.length,
                            itemBuilder: (context, index) {
                              //final user = users[index];

                              if (index <
                                  customerListController
                                      .dataListAccepted.length) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://connectuz.com/public/assets/admini/img/160x160/img1.jpg"),
                                  ),
                                  title: Text(customerListController
                                      .dataListAccepted[index].user!.fName
                                      .toString()),
                                  subtitle: Text(customerListController
                                      .dataListAccepted[index].user!.email
                                      .toString()),
                                  trailing: FollowButtonAccept(
                                    follower: customerListController
                                        .dataListAccepted[index],
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
                              child: Padding(
                            padding: const EdgeInsets.only(top: 80.0),
                            child: Text("No customers."),
                          ) //NoDataScreen(text: "No store found in nearby."),
                              ),
                        )),
            ],
          );
        },
      ),
    );
  }
}

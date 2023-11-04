import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectuz_store/view/screens/user_request/follow_button.dart';

import '../../../controller/customer_list_controller.dart';

class RequestTabScreen extends StatefulWidget {
  const RequestTabScreen({Key? key}) : super(key: key);

  @override
  _RequestTabScreenState createState() => _RequestTabScreenState();
}

class _RequestTabScreenState extends State<RequestTabScreen> {
  final ScrollController scrollController = ScrollController();
  CustomerListController mcontroller = Get.find();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    mcontroller.fetchAllStoreDataReq();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mcontroller.fetchAllStoreDataReq();
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
                          mcontroller.search.value = _searchController.text;
                        },
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) async {
                      mcontroller.search.value = value;
                      print(value);
                      mcontroller.fetchAllStoreDataReq();
                    },
                  ),
                ),
              ),
              Obx(() => customerListController.isLoadingReq.isTrue
                  ? Center(child: CircularProgressIndicator())
                  : customerListController.dataListRecieved.length > 0
                      ? Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: scrollController,
                            itemCount:
                                customerListController.dataListRecieved.length,
                            itemBuilder: (context, index) {
                              //final user = users[index];
                              bool isSent = customerListController
                                      .dataListRecieved[index].followedBy ==
                                  "store";
                              if (index <
                                  customerListController
                                      .dataListRecieved.length) {
                                return Stack(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://api.connectuz.com/public/assets/admini/img/160x160/img1.jpg"),
                                      ),
                                      title: Text(customerListController
                                              .dataListRecieved[index]
                                              .user!
                                              .fName
                                              .toString() +
                                          " " +
                                          customerListController
                                              .dataListRecieved[index]
                                              .user!
                                              .lName
                                              .toString()),
                                      subtitle: Text(customerListController
                                          .dataListRecieved[index].user!.email
                                          .toString()),
                                      trailing: FollowButtonRequest(
                                        follower: customerListController
                                            .dataListRecieved[index],
                                        controller: customerListController,
                                        index: index,
                                      ),
                                    ),
                                    isSent
                                        ? Positioned(
                                            bottom: 1,
                                            left: 16,
                                            child: Container(
                                              color: Colors.yellow,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4,
                                                        vertical: 2),
                                                child: Text("Sent"),
                                              ),
                                            ),
                                          )
                                        : Positioned(
                                            bottom: 1,
                                            left: 2,
                                            child: Container(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4,
                                                        vertical: 2),
                                                child: Text(
                                                  "Recieved",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )
                                  ],
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
                          ) //NoDataScreen(text: "No requests yet."),
                              ),
                        )),
            ],
          );
        },
      ),
    );
  }
}

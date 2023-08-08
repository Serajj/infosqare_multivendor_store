import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart_store/controller/customer_list_controller.dart';
import 'package:sixam_mart_store/data/model/response/customer_list_model.dart';
import 'package:sixam_mart_store/view/base/custom_app_bar.dart';


class FollowScreen extends StatefulWidget {

  FollowScreen({Key? key}) : super(key: key);
  @override
  _FollowScreenState createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen> {
  final TextEditingController _searchController = TextEditingController();
  //final CustomerListController  controller = Get.put(CustomerListController());

  @override
  void initState() {
    super.initState();
    print("Calling CustomerList API");
    Get.find<CustomerListController>().getCustomerList('1'); // Fetch the user list when the screen initializes
  }

  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Requests'.tr),
      body: GetBuilder<CustomerListController>(builder: (customerListController){

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
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
                    icon: Icon(Icons.search, color: Theme.of(context).primaryColor,),
                    onPressed: () {
                      // Perform the search here
                    },
                  ),
                  border: InputBorder.none,
                            ),
                          ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: customerListController.customerList!.length,
                  itemBuilder: (context, index) {
                    //final user = users[index];
                    return Container(
                      //height: 30,
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 7, bottom: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        title: Text(customerListController.customerList![index].text),
                        subtitle: Text(customerListController.customerList![index].email),
                        trailing: FollowButton(customermodel: customerListController.customerList![index])
                         /*ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isFollowing = !isFollowing;
                                if (isFollowing) {
                                  Get.find<CustomerListController>().followUser();
                                } else {
                                  Get.find<CustomerListController>().unfollowUser();
                                }
                              });
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor,
                                ),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ))),
                            child: Text(
                              isFollowing ? ' Follow ' : ' Confirm ',
                              style: TextStyle(
                                color:
                                    isFollowing ? Colors.white : Colors.white,
                              ),
                            ),
                          )*/
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class FollowButton extends StatefulWidget {
  final CustomerModel customermodel;
  const FollowButton({Key? key, required this.customermodel}) : super(key: key);

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  @override
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    isFollowing = Get.find<CustomerListController>().isFollowingUser(widget.customermodel); // Check if the user is already followed
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isFollowing = !isFollowing;
          if (isFollowing) {
            Get.find<CustomerListController>().followUser(widget.customermodel);
          } else {
            Get.find<CustomerListController>().unfollowUser(widget.customermodel);
          }
        });
      },
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor,),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    )
  )),
      child: Text(
        isFollowing ? ' Follow ' : ' Confirm ',
        style: TextStyle(
          color: isFollowing ? Colors.white : Colors.white,
        ),
      ),
    );
  }
}
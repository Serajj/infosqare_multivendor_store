import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:connectuz_store/data/model/response/profile_model.dart';

import '../../../controller/auth_controller.dart';
import '../../../controller/membership_controller.dart';
import 'membership_item_widget.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({Key? key}) : super(key: key);

  @override
  _MembershipScreenState createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  MembershipController membershipController = Get.find();
  late bool _isOwner;

  bool isAnnual = false;

  @override
  void initState() {
    super.initState();
    Get.find<AuthController>().getProfile();

    _isOwner = Get.find<AuthController>().getUserType() == 'owner';
    membershipController.getSubmittedStatus();
    membershipController.getMembershipList();
  }

  @override
  Widget build(BuildContext context) {
    ProfileModel? userInfo = Get.find<AuthController>().profileModel;
    if (!(userInfo!.membershipId == "null" || userInfo.membershipId == null)) {
      membershipController.membershipId.value =
          userInfo.membershipId.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Membership'),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   membershipController.getMembershipList();
      //   print(membershipController.dataList.length.toString());
      // }),
      body: (userInfo.membershipId == "null" || userInfo.membershipId == null)
          ? Obx(() => Column(
                children: [
                  membershipController.manualPayment.value.id != null
                      ? Column(
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "You have already uploaded payment details for a membership , please wait till it get verified.Thankyou!!..",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      : SizedBox(
                          height: 80,
                        ),
                  Container(
                    width: double.maxFinite,
                    child: Text(
                      "Choose subscription plan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("You don't have any plan purchased yet."),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          8), // Adjust the value to control the roundness
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 100),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isAnnual = false;
                                });
                              },
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  color: isAnnual ? Colors.white : Colors.green,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    "Monthly",
                                    textAlign: TextAlign.center,
                                    style: isAnnual
                                        ? TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey)
                                        : TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isAnnual = true;
                                });
                              },
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  color: isAnnual ? Colors.green : Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    "Annually",
                                    textAlign: TextAlign.center,
                                    style: isAnnual
                                        ? TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white)
                                        : TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Expanded(
                      child: Obx(() => ListView.builder(
                            itemCount: membershipController.dataList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return isAnnual
                                  ? membershipController
                                              .dataList[index].period ==
                                          'annual'
                                      ? MembershipItem(
                                          membership: membershipController
                                              .dataList[index],
                                        )
                                      : Container()
                                  : membershipController
                                              .dataList[index].period ==
                                          'monthly'
                                      ? MembershipItem(
                                          membership: membershipController
                                              .dataList[index],
                                        )
                                      : Container();
                            },
                          )))
                ],
              ))
          : Obx(() => Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: Text(
                      "Congratulation your current plan is",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: Text(
                      membershipController.currentMembership.value.title ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(30),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    userInfo.membershipStart.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16),
                                  ),
                                  Text("Started On")
                                ],
                              ),
                            ),
                            VerticalDivider(
                              width: 2,
                              color: Colors.grey,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    userInfo.membershipEnd.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16),
                                  ),
                                  Text("Valid Upto"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2,
                      child: Html(
                          data: membershipController
                              .currentMembership.value.desc),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              )),
    );
  }
}

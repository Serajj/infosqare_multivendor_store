import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectuz_store/view/base/custom_app_bar.dart';
import 'package:connectuz_store/view/screens/user_request/plan_details.dart';

class SubscriptionPlanScreen extends StatefulWidget {
  const SubscriptionPlanScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionPlanScreen> createState() => _SubscriptionPlanScreenState();
}

class _SubscriptionPlanScreenState extends State<SubscriptionPlanScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
    super.initState(); // Fetch the user list when the screen initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Requests'.tr),
        body: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 80, bottom: 50),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Choose Subscription Plan",
                  style: GoogleFonts.montserrat(
                      fontSize: 25.0, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Text(
                      "Get the best service without subscription plans \n       tailored to make streaming fun and live",
                      style: GoogleFonts.montserrat(fontSize: 11.0)),
                ),
                DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, left: 30, right: 30),
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.black38),
                              borderRadius: BorderRadius.circular(10)),
                          child: TabBar(
                            unselectedLabelColor: Colors.black,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Theme.of(context).primaryColor),
                            tabs: [
                              Tab(
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Monthly",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15.0))),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Annually",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15.0))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 360,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black38),
                            borderRadius: BorderRadius.circular(10)),
                        child: TabBarView(
                          children: [
                            subScriptionPlan(context, "\$26"),
                            subScriptionPlan(context, "\$54"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    child: Text("Continue"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SubscriptionScreen1()));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ))),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Container subScriptionPlan(BuildContext context, String amount) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 15, top: 20, bottom: 8),
      child: Column(
        children: [
          Row(
            children: [
              Text(amount,
                  style: GoogleFonts.montserrat(
                      fontSize: 40.0, fontWeight: FontWeight.w600)),
              SizedBox(
                width: 18,
              ),
              Text("/Monthly",
                  style: GoogleFonts.montserrat(
                      fontSize: 15.0, fontWeight: FontWeight.w600)),
            ],
          ),
          Row(
            children: [
              Text(
                  "Free for ever when you host \nwith Debbi. free for freelancers \nwith Client Billing",
                  style: GoogleFonts.montserrat(fontSize: 17.0)),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Icon(Icons.done, color: Theme.of(context).primaryColor),
              SizedBox(
                width: 8,
              ),
              Text("2 Projects",
                  style: GoogleFonts.montserrat(
                      fontSize: 17.0, fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: [
              Icon(Icons.done, color: Theme.of(context).primaryColor),
              SizedBox(
                width: 8,
              ),
              Text("Client Billing",
                  style: GoogleFonts.montserrat(
                      fontSize: 17.0, fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: [
              Icon(Icons.done, color: Theme.of(context).primaryColor),
              SizedBox(
                width: 8,
              ),
              Text("Free Staging",
                  style: GoogleFonts.montserrat(
                      fontSize: 17.0, fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: [
              Icon(Icons.done, color: Theme.of(context).primaryColor),
              SizedBox(
                width: 8,
              ),
              Text("Code export",
                  style: GoogleFonts.montserrat(
                      fontSize: 17.0, fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: [
              Icon(Icons.done, color: Theme.of(context).primaryColor),
              SizedBox(
                width: 8,
              ),
              Text("White labeling",
                  style: GoogleFonts.montserrat(
                      fontSize: 17.0, fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: [
              Icon(Icons.done, color: Theme.of(context).primaryColor),
              SizedBox(
                width: 8,
              ),
              Text("Site password protection",
                  style: GoogleFonts.montserrat(
                      fontSize: 17.0, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}

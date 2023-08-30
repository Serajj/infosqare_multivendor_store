import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sixam_mart_store/view/screens/user_request/monthly_subscription.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 350,
              width: 350,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: 250,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),

                  //use the positioned widget to place

                  Positioned(
                    top: 0,
                    right: 50,
                    left: 50,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle),
                      child: CircleAvatar(
                          backgroundImage: AssetImage("assets/image/logo.png")),
                    ),
                  ),

                  const Positioned(
                      top: 55, right: 15, child: Icon(Icons.close)),

                  Positioned(
                    top: 120,
                    left: 20,
                    child: Column(
                      children: [
                        Text(
                            "Subscribe our plan to get \n       premium features",
                            style: GoogleFonts.montserrat(
                                fontSize: 23.0, fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SubscriptionPlanScreen()),
                              );
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor,
                                ),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ))),
                            child: Text("Subscribe",
                                style: GoogleFonts.montserrat(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.white,
                                ),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ))),
                            child: Text("Cancel",
                                style: GoogleFonts.montserrat(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sixam_mart_store/util/dimensions.dart';
import 'package:sixam_mart_store/view/base/custom_app_bar.dart';

class SubscriptionScreen1 extends StatefulWidget {
  @override
  _SubscriptionScreen1 createState() => _SubscriptionScreen1();
}

class _SubscriptionScreen1 extends State<SubscriptionScreen1> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Requests'.tr),
        body: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 80, bottom: 50),
          child:  Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Platinum Plan", style: GoogleFonts.montserrat(fontSize: Dimensions.fontSizeOverLarge, color: Colors.black, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  Text("customized just for you", style: GoogleFonts.montserrat(fontSize: Dimensions.fontSizeSmall, color: Colors.black),),
                  const SizedBox(height: 55,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Invoice", style: GoogleFonts.montserrat(fontSize: Dimensions.fontSizeLarge, color: Colors.black,fontWeight: FontWeight.w600),),
                      Text("#00028", style: GoogleFonts.montserrat(fontSize: Dimensions.fontSizeLarge, color: Colors.black, fontWeight: FontWeight.w600),),
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Bill to", style: GoogleFonts.montserrat(fontSize: Dimensions.fontSizeLarge, color: Colors.black, fontWeight: FontWeight.w600),),
                      Text("Om Mishra", style: GoogleFonts.montserrat(fontSize: Dimensions.fontSizeLarge, color: Colors.black, fontWeight: FontWeight.w600),),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Amount Due", style: GoogleFonts.montserrat(fontSize: Dimensions.fontSizeLarge, color: Colors.grey),),
                      Text("\$99.00", style: GoogleFonts.montserrat(fontSize: Dimensions.fontSizeLarge, color: Colors.grey),),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Payment Due", style: GoogleFonts.montserrat(fontSize: Dimensions.fontSizeLarge, color: Colors.grey),),
                      Text("19 May 2023", style: GoogleFonts.montserrat(fontSize: Dimensions.fontSizeLarge, color: Colors.grey),),
                    ],
                  ),
                  const SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("PLANS", style: GoogleFonts.montserrat(fontSize: Dimensions.fontSizeLarge, color: Colors.black45, fontWeight: FontWeight.w600),),
                      Text("AMOUNT", style: GoogleFonts.montserrat(fontSize: Dimensions.fontSizeLarge, color: Colors.black45, fontWeight: FontWeight.w600),),
                    ],
                  ),
                  const SizedBox(height: 17,),
                  const Divider(
                     color: Color.fromARGB(255, 202, 201, 201),
                     height: 5, //height spacing of divider
                     thickness: 1,
                  ),
                  const SizedBox(height: 17,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Platinum", style: GoogleFonts.montserrat(fontSize: Dimensions.fontSizeLarge, color: Colors.black, fontWeight: FontWeight.w600),),
                      Text("\$99.00", style: GoogleFonts.montserrat(fontSize: Dimensions.fontSizeLarge, color: Colors.black, fontWeight: FontWeight.w600),),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("3 months", style: GoogleFonts.montserrat(fontSize: Dimensions.fontSizeLarge, color: Colors.grey),),
                      Text("Details", style: GoogleFonts.montserrat(fontSize: Dimensions.fontSizeLarge, color: Colors.grey),),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  const Divider(
                     color: Color.fromARGB(255, 202, 201, 201),
                     height: 5, //height spacing of divider
                     thickness: 1,
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total(USD)", style: GoogleFonts.montserrat(fontSize: Dimensions.fontSizeLarge, color: Colors.black, fontWeight: FontWeight.w600),),
                      Text("\$99", style: GoogleFonts.montserrat(fontSize: Dimensions.fontSizeLarge, color: Colors.black, fontWeight: FontWeight.w600),),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 75,),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor,
                              ),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ))),
                          child: Text("Pay Now", style: GoogleFonts.montserrat(fontSize: 15),),
                        ),
              )
            ],
          )
        ));
  }
}

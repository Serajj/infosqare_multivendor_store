import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../../controller/membership_controller.dart';
import '../../../data/model/response/membership_model.dart';
import '../../../helper/route_helper.dart';
import '../../base/custom_snackbar.dart';

class MembershipItem extends StatefulWidget {
  Membership membership;
  MembershipItem({Key? key, required this.membership}) : super(key: key);

  @override
  State<MembershipItem> createState() => _MembershipItemState();
}

class _MembershipItemState extends State<MembershipItem> {
  MembershipController membershipController = Get.find();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (membershipController.manualPayment.value.id != null) {
          if (membershipController.manualPayment.value.isRejected != 1) {
            showCustomSnackBar(
                "You have alredy uploaded one payment detais , please wait utill it get verified.",
                isError: true);
          }
          return;
        }
        membershipController.setSelectedmembership(widget.membership);
        Get.toNamed(RouteHelper.getMembershipPaymentRoute());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              8), // Adjust the value to control the roundness
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        margin: EdgeInsets.only(left: 24, right: 24, bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.membership.title.toString(),
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(widget.membership.price.toString() + " ₹/",
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 20)),
                        Text(" " + widget.membership.period.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Perfect for starter",
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text("Benefits",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14)),
                    ),
                    Html(data: widget.membership.desc)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

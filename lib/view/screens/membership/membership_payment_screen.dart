import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../controller/auth_controller.dart';
import '../../../controller/membership_controller.dart';
import '../../../controller/splash_controller.dart';
import '../../../data/model/response/profile_model.dart';
import '../../../helper/responsive_helper.dart';
import '../../../helper/route_helper.dart';
import '../../base/custom_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../base/custom_snackbar.dart';

class MembershipPaymentScreen extends StatefulWidget {
  const MembershipPaymentScreen({Key? key}) : super(key: key);

  @override
  _MembershipPaymentScreenState createState() =>
      _MembershipPaymentScreenState();
}

class _MembershipPaymentScreenState extends State<MembershipPaymentScreen> {
  MembershipController membershipController = Get.find();
  XFile? _imageFile;
  String? iurl;
  String generateFileName() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyyMMdd_HHmmss');
    return formatter.format(now);
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      File imageFilePicked = File(pickedFile.path);
      iurl = await uploadImageToFirebase(imageFilePicked, "xyz");
      print(iurl);
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  Future<String?> uploadImageToFirebase(File imageFile, String fileName) async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> launchGooglePay() async {
    // Define the individual parameters in separate variables
    var recipientId =
        Get.find<SplashController>().configModel!.baseUrls!.upiId.toString();
    const recipientName = 'ConnectUz';
    const merchantCode = '';
    const transactionId = '';
    const transactionRefId = '';
    const paymentDescription = 'This is for connectuz membership.';
    var amount = membershipController.selectedMembership.value.price ?? 0;

// Concatenate the variables to form the UPI URL
    var url =
        Get.find<SplashController>().configModel!.baseUrls!.upiId.toString() +
            "&am=" +
            amount.toString();

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle the case where the app cannot be launched
    }
  }

  Future<void> launchPhonePe() async {
    final url =
        'phonepe://payment?txnId=your-transaction-id&orderId=your-order-id'; // Replace with your payment details
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle the case where the app cannot be launched
    }
  }

  Future<void> launchPaytm() async {
    final url =
        'paytmmp://wallet?txn_id=your-transaction-id&order_id=your-order-id'; // Replace with your payment details
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle the case where the app cannot be launched
    }
  }

  @override
  Widget build(BuildContext context) {
    ProfileModel? userInfo = Get.find<AuthController>().profileModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('Membership Payment'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
            ),
            Container(
              width: double.maxFinite,
              child: Text(
                membershipController.selectedMembership!.value.title.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
                width: double.maxFinite,
                child: Text(
                  "This is a " +
                      membershipController.selectedMembership!.value.title
                          .toString() +
                      " plan please find details below.",
                  textAlign: TextAlign.center,
                )),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Bill to",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                  Text(
                    userInfo!.fName.toString() +
                        " " +
                        userInfo.lName.toString(),
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Amount due",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                  Text(
                    membershipController.selectedMembership!.value.price
                        .toString(),
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "PLANS",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.grey),
                  ),
                  Text(
                    "AMOUNT",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.grey),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
              child: Divider(
                thickness: 1,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    membershipController.selectedMembership!.value.title
                        .toString(),
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                  Text(
                    membershipController.selectedMembership!.value.price
                        .toString(),
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    membershipController.selectedMembership!.value.period
                        .toString(),
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                  Text(
                    "",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
              child: Divider(
                thickness: 1,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                  ),
                  Text(
                    membershipController.selectedMembership!.value.price
                        .toString(),
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                  )
                ],
              ),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Container(
            //         width: 40,
            //         child: Text(
            //           "Note : ",
            //           style:
            //               TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            //         ),
            //       ),
            //       Expanded(
            //         child: Text(
            //           "Scan/Tap and pay below QR code and submit screenshot.",
            //           style:
            //               TextStyle(fontWeight: FontWeight.w800, fontSize: 11),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 24),
            //   child: Center(
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: InkWell(
            //         onTap: () {
            //           print("Opening google pay");
            //           launchGooglePay();
            //         },
            //         child: Container(
            //           height: 200,
            //           width: 200,
            //           color: Colors.white,
            //           child: Image.network(Get.find<SplashController>()
            //               .configModel!
            //               .baseUrls!
            //               .qrImageUrl
            //               .toString()),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Center(
            //   child: Text(""),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 24),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         CustomButton(
            //           buttonText: "Add Screenshot",
            //           onPressed: () {
            //             _pickImage(ImageSource.gallery);
            //           },
            //           width: 140,
            //         ),
            //         if (_imageFile != null)
            //           CustomButton(
            //             width: 140,
            //             buttonText: "View",
            //             onPressed: () {
            //               String happy = "Happy";
            //               showDialog(
            //                   context: context,
            //                   barrierDismissible: false,
            //                   builder: (con) => Dialog(
            //                         child: Container(
            //                           height: 300,
            //                           width: MediaQuery.of(con).size.width - 50,
            //                           child: Column(
            //                             children: [
            //                               Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.end,
            //                                 children: [
            //                                   InkWell(
            //                                     onTap: () {
            //                                       Get.back();
            //                                     },
            //                                     child: Padding(
            //                                       padding:
            //                                           const EdgeInsets.all(8.0),
            //                                       child: Icon(Icons.close),
            //                                     ),
            //                                   ),
            //                                 ],
            //                               ),
            //                               if (_imageFile != null)
            //                                 Container(
            //                                     height: 150,
            //                                     child: Image.file(
            //                                         File(_imageFile!.path))),
            //                             ],
            //                           ),
            //                         ),
            //                       ));
            //             },
            //           ),
            //       ],
            //     ),
            //   ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButton(
            width: ResponsiveHelper.isDesktop(context)
                ? MediaQuery.of(context).size.width / 2.0
                : null,
            buttonText: "Buy Now",
            onPressed: () async {
              // if (_imageFile == null) {
              //   showCustomSnackBar("Please select payment screenshot first.");
              //   return;
              // }
              String model_id =
                  membershipController.selectedMembership.value.id.toString();
              String amount = membershipController
                  .selectedMembership.value.price
                  .toString();
              String desc = "For " +
                  membershipController.selectedMembership.value.title
                      .toString() +
                  " plan.";
              String image = 98.toString();
              String paymentMethod = "razor_pay";

              bool isUploaded = await membershipController.purchaseMembership(
                  amount, paymentMethod, model_id);
              // if (isUploaded) {
              //   showCustomSnackBar(
              //       "Payment image added please wait for admin approval , we will get back to you shortly.",
              //       isError: false);
              //   Get.back();
              //   Get.offAndToNamed(RouteHelper.initial);
              // } else {
              //   showCustomSnackBar("Failed to upload payment reciept",
              //       isError: true);
              // }
            },
          ),
        ),
      ),
    );
  }
}

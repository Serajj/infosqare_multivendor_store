import 'dart:io';

import 'package:connectuz_store/controller/employee_controller.dart';
import 'package:connectuz_store/data/model/response/employee_model.dart';
import 'package:connectuz_store/util/app_constants.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:connectuz_store/controller/auth_controller.dart';
import 'package:connectuz_store/controller/delivery_man_controller.dart';
import 'package:connectuz_store/controller/splash_controller.dart';
import 'package:connectuz_store/data/model/response/delivery_man_model.dart';
import 'package:connectuz_store/util/dimensions.dart';
import 'package:connectuz_store/util/images.dart';
import 'package:connectuz_store/util/styles.dart';
import 'package:connectuz_store/view/base/custom_app_bar.dart';
import 'package:connectuz_store/view/base/custom_button.dart';
import 'package:connectuz_store/view/base/custom_image.dart';
import 'package:connectuz_store/view/base/custom_snackbar.dart';
import 'package:connectuz_store/view/base/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_number/phone_number.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controller/store_controller.dart';

class AddEmployeeScreen extends StatefulWidget {
  final Employee? deliveryMan;
  const AddEmployeeScreen({Key? key, required this.deliveryMan})
      : super(key: key);

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _fNameNode = FocusNode();
  final FocusNode _lNameNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _phoneNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _identityNumberNode = FocusNode();
  late bool _update;
  Employee? _deliveryMan;
  String? _countryDialCode;

  @override
  void initState() {
    super.initState();
    _deliveryMan = widget.deliveryMan;
    _update = widget.deliveryMan != null;
    _countryDialCode = CountryCode.fromCountryCode(
            Get.find<SplashController>().configModel!.country!)
        .dialCode;
    Get.find<EmployeeController>().pickImage(false, true);
    if (_update) {
      print("true editing");
      _fNameController.text = _deliveryMan!.fName!;
      _lNameController.text = _deliveryMan!.lName!;
      _emailController.text = _deliveryMan!.email!;
      _phoneController.text = _deliveryMan!.phone!;
      Get.find<EmployeeController>()
          .setIdentityTypeIndex(_deliveryMan!.role, false);
      _splitPhone(_deliveryMan!.phone);
    } else {
      _deliveryMan = Employee();
      Get.find<EmployeeController>().setIdentityTypeIndex(
          Get.find<EmployeeController>().employeeRoles?[0], false);
      //Get.find<DeliveryManController>().setIdentityTypeIndex(Get.find<DeliveryManController>().identityTypeList[0], false);
      print("deliveryman $_deliveryMan");
    }
  }

  void _splitPhone(String? phone) async {
    if (!GetPlatform.isWeb) {
      try {
        PhoneNumber phoneNumber = await PhoneNumberUtil().parse(phone!);
        _countryDialCode = '+${phoneNumber.countryCode}';
        _phoneController.text = phoneNumber.nationalNumber;
        setState(() {});
      } catch (_) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: widget.deliveryMan != null
              ? 'Update Employee'.tr
              : 'Add new employee'.tr),
      body: GetBuilder<EmployeeController>(builder: (dmController) {
        return Column(children: [
          Expanded(
              child: SingleChildScrollView(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            physics: const BouncingScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Employee Image'.tr,
                    style: robotoRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).disabledColor),
                  )),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    '(${'max_size_2_mb'.tr})',
                    style: robotoRegular.copyWith(
                        fontSize: Dimensions.fontSizeExtraSmall,
                        color: Theme.of(context).colorScheme.error),
                  )),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Align(
                  alignment: Alignment.center,
                  child: Stack(children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusSmall),
                      child: dmController.pickedImage != null
                          ? GetPlatform.isWeb
                              ? Image.network(
                                  dmController.pickedImage!.path,
                                  width: 150,
                                  height: 120,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(dmController.pickedImage!.path),
                                  width: 150,
                                  height: 120,
                                  fit: BoxFit.cover,
                                )
                          : FadeInImage.assetNetwork(
                              placeholder: Images.placeholder,
                              image:
                                  '${Get.find<SplashController>().configModel!.baseUrls!.employeeImageUrl}/${_deliveryMan!.image ?? ''}',
                              height: 120,
                              width: 150,
                              fit: BoxFit.cover,
                              imageErrorBuilder: (c, o, s) => Image.asset(
                                  Images.placeholder,
                                  height: 120,
                                  width: 150,
                                  fit: BoxFit.cover),
                            ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      top: 0,
                      left: 0,
                      child: InkWell(
                        onTap: () => dmController.pickImage(true, false),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusSmall),
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).primaryColor),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.camera_alt,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ])),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              Row(children: [
                Expanded(
                    child: MyTextField(
                  hintText: 'first_name'.tr,
                  controller: _fNameController,
                  capitalization: TextCapitalization.words,
                  inputType: TextInputType.name,
                  focusNode: _fNameNode,
                  nextFocus: _lNameNode,
                )),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(
                    child: MyTextField(
                  hintText: 'last_name'.tr,
                  controller: _lNameController,
                  capitalization: TextCapitalization.words,
                  inputType: TextInputType.name,
                  focusNode: _lNameNode,
                  nextFocus: _emailNode,
                )),
              ]),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              MyTextField(
                isEnabled: !_update,
                hintText: 'email'.tr,
                controller: _emailController,
                focusNode: _emailNode,
                nextFocus: _phoneNode,
                inputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              Row(children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[Get.isDarkMode ? 800 : 200]!,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 5))
                    ],
                  ),
                  child: CountryCodePicker(
                    onChanged: (CountryCode countryCode) {
                      _countryDialCode = countryCode.dialCode;
                    },
                    initialSelection: _countryDialCode,
                    favorite: [_countryDialCode!],
                    showDropDownButton: true,
                    padding: EdgeInsets.zero,
                    showFlagMain: true,
                    flagWidth: 30,
                    textStyle: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(
                    flex: 1,
                    child: MyTextField(
                      isEnabled: !_update,
                      hintText: 'phone'.tr,
                      controller: _phoneController,
                      focusNode: _phoneNode,
                      nextFocus: _passwordNode,
                      inputType: TextInputType.phone,
                      title: false,
                    )),
              ]),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              MyTextField(
                hintText: 'password'.tr,
                controller: _passwordController,
                focusNode: _passwordNode,
                nextFocus: _identityNumberNode,
                inputType: TextInputType.visiblePassword,
                isPassword: true,
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              Row(children: [
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(
                        'Role'.tr,
                        style: robotoRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).disabledColor),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      dmController.employeeRoles!.length == 0
                          ? Text(
                              "You don't have roles , click to redirect web pannel and add roles.",
                              style: TextStyle(color: Colors.red, fontSize: 10),
                            )
                          : SizedBox(),
                      dmController.employeeRoles!.length == 0
                          ? ElevatedButton(
                              onPressed: () async {
                                String shareUrl =
                                    '${AppConstants.baseUrl}/store-panel/custom-role/create?token=${Get.find<AuthController>().getUserToken()}';
                                final Uri url = Uri.parse(shareUrl);
                                if (!await launchUrl(url)) {
                                  showCustomSnackBar(
                                      'Error while redirection, please ensure you have browser installed in your device.'
                                          .tr);
                                }
                              },
                              child: Text("Add role"))
                          : SizedBox(),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeSmall),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusSmall),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[Get.isDarkMode ? 800 : 200]!,
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 5))
                          ],
                        ),
                        child: DropdownButton<Role>(
                          value: dmController.employeeRoles!.length > 0
                              ? dmController.employeeRoles?.firstWhereOrNull(
                                  (element) =>
                                      element.id ==
                                      dmController.selectedRole?.id)
                              : null,
                          // value: dmController.selectedRole,
                          items: dmController.employeeRoles?.map((Role value) {
                            return DropdownMenuItem<Role>(
                              value: value,
                              child: Text(value.name.toString()),
                            );
                          }).toList(),
                          onChanged: (value) {
                            dmController.setIdentityTypeIndex(value, true);
                          },
                          isExpanded: true,
                          underline: const SizedBox(),
                        ),
                      ),
                    ])),
                // const SizedBox(width: Dimensions.paddingSizeSmall),
                // Expanded(
                //     child: MyTextField(
                //   hintText: 'identity_number'.tr,
                //   controller: _identityNumberController,
                //   focusNode: _identityNumberNode,
                //   inputAction: TextInputAction.done,
                // )),
              ]),
              const SizedBox(height: Dimensions.paddingSizeLarge),
            ]),
          )),
          !dmController.isLoading
              ? CustomButton(
                  buttonText: _update ? 'update'.tr : 'add'.tr,
                  margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  height: 50,
                  onPressed: () => _addDeliveryMan(dmController),
                )
              : const Center(child: CircularProgressIndicator()),
        ]);
      }),
    );
  }

  void _addDeliveryMan(EmployeeController dmController) async {
    if (dmController.employeeRoles!.length == 0) {
      showCustomSnackBar(
          'Please create employees role first by login to web pannel');
    }
    print(dmController.selectedRole?.name);
    String fName = _fNameController.text.trim();
    String lName = _lNameController.text.trim();
    String email = _emailController.text.trim();
    String phone = _phoneController.text.trim();
    String password = _passwordController.text.trim();
    int? identityNumber = dmController.selectedRole?.id ?? null;

    String numberWithCountryCode = _countryDialCode! + phone;
    bool isValid = GetPlatform.isWeb ? true : false;
    if (!GetPlatform.isWeb) {
      try {
        PhoneNumber phoneNumber =
            await PhoneNumberUtil().parse(numberWithCountryCode);
        numberWithCountryCode =
            '+${phoneNumber.countryCode}${phoneNumber.nationalNumber}';
        isValid = true;
      } catch (_) {
        debugPrint("Exception thrown");
      }
    }
    if (fName.isEmpty) {
      showCustomSnackBar('enter_employee_first_name'.tr);
    } else if (lName.isEmpty) {
      showCustomSnackBar('enter_employee_last_name'.tr);
    } else if (email.isEmpty) {
      showCustomSnackBar('Enter employee email address'.tr);
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnackBar('Enter valid email address'.tr);
    } else if (phone.isEmpty) {
      showCustomSnackBar('enter_employee_phone_number'.tr);
    } else if (!isValid) {
      showCustomSnackBar('enter_a_valid_phone_number'.tr);
    } else if (password.isEmpty && !_update) {
      showCustomSnackBar('enter_password_for_employee'.tr);
    } else if (password.length < 6 && !_update) {
      showCustomSnackBar('password_should_be'.tr);
    } else if (identityNumber! == 0) {
      showCustomSnackBar('Select role ${identityNumber}');
    } else if (!_update && dmController.pickedImage == null) {
      showCustomSnackBar('upload_employee_image'.tr);
    } else {
      print("Adding delivery man");
      _deliveryMan!.fName = fName;
      _deliveryMan!.lName = lName;
      _deliveryMan!.email = email;
      _deliveryMan!.phone = numberWithCountryCode;
      _deliveryMan!.employeeRoleId = dmController.selectedRole?.id;
      dmController.addDeliveryMan(
        _deliveryMan!,
        password,
        Get.find<AuthController>().getUserToken(),
        !_update,
      );
    }
  }
}

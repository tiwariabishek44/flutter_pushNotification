import 'package:flutter/gestures.dart';
import 'package:merocanteen/app/config/colors.dart';
import 'package:merocanteen/app/config/style.dart';
import 'package:merocanteen/app/modules/common/login/login_controller.dart';
import 'package:merocanteen/app/modules/common/register/register.dart';
import 'package:merocanteen/app/modules/brands/brand_page.dart';
import 'package:merocanteen/app/modules/user_module/student_mainscreen/user_mainScreen.dart';
import 'package:merocanteen/app/widget/customized_button.dart';
import 'package:merocanteen/app/widget/customized_textfield.dart';
import 'package:merocanteen/app/widget/welcome_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VendorEntro extends StatefulWidget {
  const VendorEntro({super.key});

  @override
  State<VendorEntro> createState() => _VendorEntroState();
}

class _VendorEntroState extends State<VendorEntro> {
  final logincontroller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenHorizontalPadding,
          child: Form(
            key: logincontroller.vendorLoginFromkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Container(
                      height: 5.h,
                      width: 5.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_sharp),
                          onPressed: () {
                            Get.back();
                          }),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                WelcomeHeading(
                  mainHeading: 'Welcome to HamroCanteen',
                  subHeading: "Continue As a Canteen",
                ),
                SizedBox(height: 10),
                CustomizedTextfield(
                  validator: logincontroller.vendorVlidator,
                  icon: Icons.view_agenda_rounded,
                  myController: logincontroller.vendorCode,
                  hintText: "Enter Canteen Code",
                ),
                CustomButton(
                    text: 'Continue',
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      logincontroller.vendorloginSubmit();
                    },
                    isLoading: false)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

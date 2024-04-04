import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merocanteen/app/modules/common/login/login_page.dart';
import 'package:merocanteen/app/modules/common/loginoption/login_option_controller.dart';
import 'package:merocanteen/app/modules/common/loginoption/vendor_entry/vendor_entry.dart';
import 'package:merocanteen/app/modules/vendor_modules/vendor_main_Screen/vendr_main_Screen.dart';
import 'package:merocanteen/app/widget/customized_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginOptionView extends StatelessWidget {
  final loginOptionController = Get.put(LoginScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.red,
              height: 60.h,
              width: 200.w,
            ),
            Padding(
              padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 2.h),
              child: Column(
                children: [
                  Text(
                    'Continue as:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomButton(
                      text: 'Continue As Student',
                      onPressed: () {
                        loginOptionController.isUser.value = true;
                        Get.to(() => LoginScreen(),
                            transition: Transition.rightToLeft);
                      },
                      isLoading: false),
                  SizedBox(height: 15),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: Color.fromARGB(255, 97, 96, 96),
                          height: 0.5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'OR',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Color.fromARGB(255, 97, 96, 96),
                          height: 0.5,
                        ),
                      ),
                    ],
                  ),
                  CustomButton(
                      text: 'Continue As Canteen',
                      onPressed: () {
                        loginOptionController.isUser.value = false;
                        Get.to(() => LoginScreen(),
                            transition: Transition.rightToLeft);
                      },
                      isLoading: false),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

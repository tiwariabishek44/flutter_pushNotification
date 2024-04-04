import 'package:flutter/gestures.dart';
import 'package:merocanteen/app/config/colors.dart';
import 'package:merocanteen/app/config/style.dart';
import 'package:merocanteen/app/modules/common/login/login_controller.dart';
import 'package:merocanteen/app/modules/common/loginoption/login_option_controller.dart';
import 'package:merocanteen/app/modules/common/register/register.dart';
import 'package:merocanteen/app/modules/brands/brand_page.dart';
import 'package:merocanteen/app/modules/user_module/student_mainscreen/user_mainScreen.dart';
import 'package:merocanteen/app/widget/customized_button.dart';
import 'package:merocanteen/app/widget/customized_textfield.dart';
import 'package:merocanteen/app/widget/welcome_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final logincontroller = Get.put(LoginController());
  final loginScreenController = Get.put(LoginScreenController());

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenHorizontalPadding,
          child: Form(
            key: logincontroller.loginFromkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                WelcomeHeading(
                  mainHeading: 'Welcome to HamroCanteen',
                  subHeading: loginScreenController.isUser.value
                      ? "Login As Student"
                      : "Login AS Canteen",
                ),
                SizedBox(height: 10),
                CustomizedTextfield(
                  validator: logincontroller.emailValidator,
                  icon: Icons.email_outlined,
                  myController: logincontroller.emailcontroller,
                  hintText: "UserName",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.7.h),
                  child: TextFormField(
                    validator: logincontroller.passwordValidator,
                    controller: logincontroller.passwordcontroller,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        size: 20.sp,
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          color: AppColors.secondaryColor, fontSize: 17.sp),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.secondaryColor, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.secondaryColor, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off_outlined,
                          color: AppColors.secondaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {},
                      child: const Text("Forgot Password?",
                          style: TextStyle(
                            color: Color(0xff6A707C),
                            fontSize: 15,
                          )),
                    ),
                  ),
                ),
                Obx(() => CustomButton(
                    text: "Login",
                    onPressed: () {
                      FocusScope.of(context).unfocus();

                      logincontroller.loginSubmit(context);
                    },
                    isLoading: logincontroller.isloading.value)),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: Color.fromARGB(255, 213, 213, 213),
                          height: 0.5,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'OR',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Color.fromARGB(255, 213, 213, 213),
                          height: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => RegisterPage(),
                            transition: Transition.rightToLeft,
                            duration: duration);
                        // Handle navigation to registration page
                        // For example, Navigator.push(context, MaterialPageRoute(builder: (context) => YourRegistrationPage()));
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 17.sp,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

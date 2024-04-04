import 'package:flutter/gestures.dart';
import 'package:merocanteen/app/config/colors.dart';
import 'package:merocanteen/app/config/style.dart';
import 'package:merocanteen/app/modules/common/login/login_controller.dart';
import 'package:merocanteen/app/modules/common/register/register_controller.dart';
import 'package:merocanteen/app/widget/customized_button.dart';
import 'package:merocanteen/app/widget/customized_textfield.dart';
import 'package:merocanteen/app/widget/welcome_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegisterPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api

  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final registercontroller = Get.put(RegisterController());
  String? _selectedOption;
  final List<String> options = [
    'BscCSIT-1st Sem',
    'BscCSIT-2nd Sem',
    'BscCSIT-3rd Sem',
    'BscCSIT-4th Sem',
    'BscCSIT-5th Sem',
    'BscCSIT-6th Sem',
    'BscCSIT-7th Sem',
    'BscCSIT-8th Sem',
    'BCA-1st Sem',
    'BCA-2nd Sem',
    'BCA-3rd Sem',
    'BCA-4th Sem',
    'BCA-5th Sem',
    'BCA-6th Sem',
    'BCA-7th Sem',
    'BCA-8th Sem',
  ];
  // Replace with your own options

  bool _isPasswordVisible = false;
  bool _isconrnformPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          title: const Text("Account Register"),
          scrolledUnderElevation: 0,
        ),
        body: Padding(
          padding: AppPadding.screenHorizontalPadding,
          child: Column(children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Form(
              key: registercontroller.registerFromkey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      registercontroller.pickImages();
                    },
                    child: Obx(() => CircleAvatar(
                          radius: 35.sp,
                          backgroundColor: AppColors.greyColor.withOpacity(0.4),
                          child: registercontroller.image.value.path.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_a_photo,
                                    ),
                                    Text(
                                      'Upload an Image',
                                      style: AppStyles.listTileTitle,
                                    ),
                                  ],
                                )
                              : ClipOval(
                                  child: Image.file(
                                    registercontroller.image.value!,
                                    fit: BoxFit.fill,
                                    width: 35
                                        .w, // Adjust the width and height as needed
                                    height: 35.w,
                                  ),
                                ),
                        )),
                  ),
                  SizedBox(
                    height: 5.w,
                  ),
                  CustomizedTextfield(
                    validator: registercontroller.usernameValidator,
                    icon: Icons.email,
                    myController: registercontroller.emailcontroller,
                    hintText: "Email",
                  ),
                  CustomizedTextfield(
                    validator: registercontroller.phoneValidator,
                    icon: Icons.phone,
                    myController: registercontroller.phonenocontroller,
                    hintText: "Phone",
                  ),
                  CustomizedTextfield(
                    validator: registercontroller.usernameValidator,
                    icon: Icons.person,
                    myController: registercontroller.namecontroller,
                    hintText: "Name",
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.7.h),
                    child: Container(
                      height: 6.5.h,
                      padding: EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: AppColors.secondaryColor),
                      ),
                      child: DropdownButton<String>(
                        value: _selectedOption,
                        hint: Row(
                          children: [
                            Icon(
                              Icons.class_,
                              size: 20.sp,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              'Select a Class',
                              style: TextStyle(
                                  color: AppColors.secondaryColor,
                                  fontSize: 17.sp),
                            ),
                          ],
                        ), // Initial hint
                        icon: Icon(Icons.arrow_drop_down),

                        iconSize: 20.sp,
                        elevation: 8,
                        style: TextStyle(color: AppColors.secondaryColor),
                        underline: SizedBox(),
                        isExpanded: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedOption = newValue;
                          });
                          print('Selected: $_selectedOption');
                        },
                        items: options
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  // Display selected value at bottom when an option is selected

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.7.h),
                    child: TextFormField(
                      validator: registercontroller.passwordValidator,
                      controller: registercontroller.passwordcontroller,
                      obscureText: !_isPasswordVisible, // Toggle the visibility
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            color: AppColors.secondaryColor, fontSize: 17.sp),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.secondaryColor, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.secondaryColor, width: 1),
                            borderRadius: BorderRadius.circular(10)),
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.7.h),
                    child: TextFormField(
                      validator: registercontroller.confirmPasswordValidator,
                      controller: registercontroller.confirmPasswordController,
                      obscureText:
                          !_isconrnformPasswordVisible, // Toggle the visibility
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(
                            color: AppColors.secondaryColor, fontSize: 17.sp),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.secondaryColor, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.secondaryColor, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isconrnformPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _isconrnformPasswordVisible =
                                  !_isconrnformPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      registercontroller.termsAndConditions.value =
                          !registercontroller.termsAndConditions.value;
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                          () => Checkbox(
                            value: registercontroller.termsAndConditions.value,
                            onChanged: (value) {
                              registercontroller.termsAndConditions.value =
                                  value!;
                            },
                            activeColor: AppColors.primaryColor,
                            checkColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.5),
                            ),
                            splashRadius: 1.5.h,
                            side: const BorderSide(
                              color: AppColors.primaryColor,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        Flexible(
                          child: RichText(
                            softWrap: true,
                            maxLines: 2,
                            text: TextSpan(
                              text: "I have read and accept the ",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "Terms and Privacy Policy",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
                                  style: TextStyle(
                                    fontSize: 15.5.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() => CustomButton(
                        text: "Register",
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          registercontroller
                              .registerSubmit(_selectedOption.toString());
                        },
                        isLoading: registercontroller.isregisterloading.value,
                      )),

                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )))
          ]),
        ));
  }
}

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:merocanteen/app/models/users_model.dart';
import 'package:merocanteen/app/modules/user_module/student_mainscreen/user_mainScreen.dart';
import 'package:merocanteen/app/modules/vendor_modules/vendor_main_Screen/vendr_main_Screen.dart';
import 'package:merocanteen/app/widget/custom_snackbar.dart';
import 'package:merocanteen/app/widget/splash_screen.dart';

class PriceUpdateController extends GetxController {
  final price = TextEditingController();

  var isloading = false.obs;

  final priceFormKey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
  }

  void priceSubmit() {
    if (priceFormKey.currentState!.validate()) {
      log('${double.parse(price.text.trim())}');
    }
  }

  String? priceValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your Canteen Code';
    }

    // Return null if the entered email is valid
    return null;
  }
}

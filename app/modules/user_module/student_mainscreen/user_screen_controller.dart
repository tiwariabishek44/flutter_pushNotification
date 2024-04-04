import 'package:merocanteen/app/modules/user_module/home/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserScreenController extends GetxController {
  var currentTab = 0.obs;
  final PageStorageBucket bucket = PageStorageBucket();
  Rx<Widget> currentScreen = Rx<Widget>(MyHomePage());
}

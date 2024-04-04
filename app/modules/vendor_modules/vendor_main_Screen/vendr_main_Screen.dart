import 'dart:developer';

import 'package:merocanteen/app/modules/user_module/orders/orders_controller.dart';
import 'package:merocanteen/app/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merocanteen/app/modules/vendor_modules/menue/view/menue_view.dart';
import 'package:merocanteen/app/modules/vendor_modules/class_wise_analytics/class_reoprt_controller.dart';
import 'package:merocanteen/app/modules/vendor_modules/order_requirements/view/order_requirement_view.dart';
import 'package:merocanteen/app/modules/vendor_modules/dashboard/salse_controller.dart';
import 'package:merocanteen/app/modules/vendor_modules/orders_checkout/orders_screen.dart';
import 'package:merocanteen/app/modules/vendor_modules/dashboard/dashboard_page.dart';
import 'package:merocanteen/app/modules/vendor_modules/setting/setting_view.dart';
import 'package:merocanteen/app/modules/vendor_modules/vendor_main_Screen/main_screen_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CanteenMainScreenView extends StatelessWidget {
  CanteenMainScreenView({Key? key});

  final userController = Get.put(VendorScreenController());

  final List<Widget> pages = [
    DshBoard(),
    OrderRequirement(),
    SettingView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => PageStorage(
          bucket: userController.bucket,
          child: userController.currentScreen.value,
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Color.fromARGB(
                    255, 210, 207, 207), // Specify your desired border color
                width: 0.50, // Specify the border width
              ),
            ),
          ),
          height: 7.5.h,
          child: MyBottomNavigationBar(
            currentIndex: userController.currentTab.value,
            onTap: (index) {
              userController.currentTab.value = index;
              userController.currentScreen.value = pages[index];
            },
            items: [
              MyBottomNavigationBarItem(
                  nonSelectedicon: Icons.dashboard_outlined,
                  icon: Icons.dashboard,
                  label: 'Dashboard'),
              MyBottomNavigationBarItem(
                  nonSelectedicon: Icons.shopping_cart_outlined,
                  icon: Icons.shopping_cart,
                  label: 'Requirement'),
              MyBottomNavigationBarItem(
                  nonSelectedicon: Icons.settings_outlined,
                  icon: Icons.settings,
                  label: 'Settings'),
            ],
          ),
        ),
      ),
    );
  }
}

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<MyBottomNavigationBarItem> items;

  MyBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: items.map((item) {
        var index = items.indexOf(item);
        return Expanded(
          child: InkWell(
            onTap: () => onTap(index),
            splashColor: Colors.transparent, // Disable tap effect

            child: item.build(index == currentIndex),
          ),
        );
      }).toList(),
    );
  }
}

class MyBottomNavigationBarItem {
  final IconData icon;
  final IconData nonSelectedicon;

  final String label;

  MyBottomNavigationBarItem({
    required this.nonSelectedicon,
    required this.icon,
    required this.label,
  });

  Widget build(bool isSelected) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? icon : nonSelectedicon,
            color: isSelected
                ? Colors.black
                : const Color.fromARGB(255, 69, 67, 67),
            // Outline the icon if not selected
            size: 20.0.sp,
            semanticLabel: label,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? Colors.black
                  : const Color.fromARGB(255, 69, 67, 67),
            ),
          ),
        ],
      ),
    );
  }
}

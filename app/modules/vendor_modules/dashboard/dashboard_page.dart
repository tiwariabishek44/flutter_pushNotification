import 'package:get/get.dart';
import 'package:merocanteen/app/config/colors.dart';

import 'package:flutter/material.dart';
import 'package:merocanteen/app/config/style.dart';
import 'package:merocanteen/app/modules/common/login/login_controller.dart';
import 'package:merocanteen/app/modules/user_module/home/product_controller.dart';
import 'package:merocanteen/app/modules/vendor_modules/menue/view/menue_view.dart';
import 'package:merocanteen/app/modules/vendor_modules/analytics/view/analytics_page.dart';
import 'package:merocanteen/app/modules/vendor_modules/class_wise_analytics/view/class_wise_analysis.dart';
import 'package:merocanteen/app/modules/vendor_modules/orders_holds/view/order_hold_view.dart';
import 'package:merocanteen/app/modules/vendor_modules/dashboard/demand_supply.dart';
import 'package:merocanteen/app/modules/vendor_modules/order_requirements/view/order_requirement_view.dart';
import 'package:intl/intl.dart';
import 'package:merocanteen/app/modules/vendor_modules/dashboard/salse_controller.dart';
import 'package:merocanteen/app/modules/vendor_modules/orders_checkout/orders_screen.dart';
import 'package:merocanteen/app/widget/confirmation_dialog.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DshBoard extends StatelessWidget {
  final salseContorlller = Get.put(SalsesController());

  @override
  Widget build(BuildContext context) {
    salseContorlller.fetchRequirement();

    salseContorlller.fetchTotalOrder();
    final homepagecontroller = Get.put(ProductController());

    DateTime currentDate = DateTime.now();

    NepaliDateTime nepaliDateTime = NepaliDateTime.fromDateTime(currentDate);

    String formattedDate =
        DateFormat('dd/MM/yyyy\'', 'en').format(nepaliDateTime);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dashboard",
                style: AppStyles.appbar,
              ),
              Text(
                formattedDate, // Display Nepali date in the app bar
                style: AppStyles.listTilesubTitle,
              ),
            ],
          ),
        ),
      ),
      // Add the rest of your app content here

      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenHorizontalPadding,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Quick Summary",
                  style: AppStyles.mainHeading,
                ),
              ),
              Row(
                children: [
                  Obx(() => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.iconColors)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 2.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Total Order',
                                style: AppStyles.listTileTitle,
                              ),
                              // Add spacing between the texts
                              Text(
                                "Rs. " +
                                    salseContorlller.totalorderGRandTotal.value
                                        .toInt()
                                        .toString(),
                                style: AppStyles.topicsHeading,
                              ),
                            ],
                          ),
                        ),
                      )),
                  SizedBox(
                    width: 5.w,
                  ),
                  Obx(() => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.iconColors)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 2.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Total Sales',
                                style: AppStyles.listTileTitle,
                              ),
                              Text(
                                "Rs. " +
                                    salseContorlller.grandTotal.value
                                        .toInt()
                                        .toString(),
                                style: AppStyles.topicsHeading,
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Divider(
                height: 1.h,
                thickness: 1.h,
                color: AppColors.greyColor,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Manager Activity",
                    style: AppStyles.topicsHeading,
                  )),
              SizedBox(
                height: 1.h,
              ),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                childAspectRatio: 1.3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  buildClickableIcon(
                    icon: Icons.restaurant_menu,
                    label: 'Canteen Meal',
                    onTap: () {
                      // Handle click for Menu Management
                      Get.to(() => VHomePage(),
                          transition: Transition.rightToLeft,
                          duration: duration);
                    },
                  ),
                  buildClickableIcon(
                    icon: Icons.production_quantity_limits,
                    label: 'Orders Req.',
                    onTap: () {
                      // Handle click for Order Management
                      Get.to(() => OrderRequirement(),
                          transition: Transition.rightToLeft,
                          duration: duration);
                    },
                  ),
                  buildClickableIcon(
                    icon: Icons.analytics,
                    label: 'Analytics',
                    onTap: () {
                      // Handle click for Analytics\
                      Get.to(() => AnalyticsPage(),
                          transition: Transition.rightToLeft,
                          duration: duration);
                    },
                  ),
                  buildClickableIcon(
                    icon: Icons.class_,
                    label: 'Class Analysis',
                    onTap: () {
                      // Handle click for Analytics\
                      Get.to(() => Classanalytics(),
                          transition: Transition.rightToLeft,
                          duration: duration);
                    },
                  ),
                  buildClickableIcon(
                    icon: Icons.cancel_presentation,
                    label: 'Orders Hold',
                    onTap: () {
                      // Handle click for Analytics\
                      Get.to(() => OrderCancel(),
                          transition: Transition.rightToLeft,
                          duration: duration);
                    },
                  ),
                  buildClickableIcon(
                    icon: Icons.check,
                    label: 'Order Checkout',
                    onTap: () {
                      // Handle click for Analytics\
                      Get.to(() => OrderCheckoutPage(),
                          transition: Transition.rightToLeft,
                          duration: duration);
                    },
                  )
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Divider(
                height: 1.h,
                thickness: 1.h,
                color: AppColors.greyColor,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Sales Report",
                      style: AppStyles.topicsHeading,
                    )),
              ),
              DemandSupply(),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build each clickable icon item
  Widget buildClickableIcon({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.secondaryColor),
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: Color.fromARGB(255, 24, 20, 19),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                label,
                style: TextStyle(
                  color: const Color.fromARGB(255, 59, 57, 57),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

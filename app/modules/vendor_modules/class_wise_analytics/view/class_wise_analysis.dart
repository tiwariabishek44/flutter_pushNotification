import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merocanteen/app/config/colors.dart';
import 'package:merocanteen/app/config/style.dart';
import 'package:merocanteen/app/modules/vendor_modules/class_wise_analytics/class_reoprt_controller.dart';
import 'package:intl/intl.dart';
import 'package:merocanteen/app/modules/vendor_modules/class_wise_analytics/view/class_remaning_order_tab.dart';
import 'package:merocanteen/app/modules/vendor_modules/class_wise_analytics/view/class_total_order_tab.dart';
import 'package:merocanteen/app/widget/empty_cart_page.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Classanalytics extends StatefulWidget {
  @override
  State<Classanalytics> createState() => _ClassanalyticsState();
}

class _ClassanalyticsState extends State<Classanalytics> {
  final orderController = Get.put(ClassReportController());
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();

    // ignore: deprecated_member_use
    NepaliDateTime nepaliDateTime = NepaliDateTime.fromDateTime(currentDate);

    String formattedDate =
        DateFormat('dd/MM/yyyy\'', 'en').format(nepaliDateTime);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Class Analytics",
                  style: AppStyles.appbar,
                ),
                Text(
                  formattedDate,
                  style: AppStyles.listTilesubTitle,
                ),
              ],
            ),
          ),
          bottom: const TabBar(
            indicatorColor: AppColors.iconColors,
            labelColor: AppColors.iconColors,
            indicatorWeight: 1,
            automaticIndicatorColorAdjustment: true,
            tabs: [
              Tab(text: 'Total Order'),
              Tab(text: 'Remaning Orders'),
            ],
          ),
        ),
        body: TabBarView(
          children: [ClassTotalOrdersTab(), ClassRemaningOrdersTab()],
        ),
      ),
    );
  }
}

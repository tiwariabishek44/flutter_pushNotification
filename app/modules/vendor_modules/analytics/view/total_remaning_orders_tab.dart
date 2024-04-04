import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merocanteen/app/config/colors.dart';
import 'package:merocanteen/app/modules/vendor_modules/class_wise_analytics/class_reoprt_controller.dart';
import 'package:intl/intl.dart';
import 'package:merocanteen/app/modules/vendor_modules/analytics/remaning_orders_controller.dart';
import 'package:merocanteen/app/modules/vendor_modules/widget/list_tile_contailer.dart';
import 'package:merocanteen/app/widget/empty_cart_page.dart';
import 'package:merocanteen/app/widget/loading_screen.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TotalRemaningOrdersTab extends StatefulWidget {
  @override
  State<TotalRemaningOrdersTab> createState() => _TotalRemaningOrdersTabState();
}

class _TotalRemaningOrdersTabState extends State<TotalRemaningOrdersTab> {
  final remaningOrderController = Get.put(RemaningOrdersController());

  int selectedIndex = -1;

  String dat = '';

  @override
  void initState() {
    super.initState();
    checkTimeAndSetDate();
  }

  void checkTimeAndSetDate() {
    DateTime currentDate = DateTime.now();
    NepaliDateTime nepaliDateTime = NepaliDateTime.fromDateTime(currentDate);

    setState(() {
      selectedIndex = 0;
      dat = DateFormat('dd/MM/yyyy\'', 'en').format(nepaliDateTime);
    });
    remaningOrderController.fetchMeal(selectedIndex.toInt(), dat);
    // 1 am or later
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();

    NepaliDateTime nepaliDateTime = NepaliDateTime.fromDateTime(currentDate);

    String formattedDate =
        DateFormat('dd/MM/yyyy\'', 'en').format(nepaliDateTime);
    remaningOrderController.date.value = formattedDate;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: remaningOrderController.timeSlots.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            remaningOrderController.fetchMeal(
                                selectedIndex.toInt(), dat);
                          });
                        },
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: selectedIndex == index
                                ? Color.fromARGB(255, 9, 9, 9)
                                : const Color.fromARGB(255, 247, 245, 245),
                          ),
                          child: Center(
                            child: Text(
                              remaningOrderController.timeSlots[index],
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: selectedIndex == index
                                      ? AppColors.backgroundColor
                                      : Color.fromARGB(255, 84, 82, 82)),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Expanded(
              flex: 13,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() {
                    if (remaningOrderController.isLoading.value) {
                      // Show a loading screen while data is being fetched
                      return LoadingScreen();
                    } else {
                      if (remaningOrderController
                              .remaningOrderResponse.value.response!.length ==
                          0) {
                        // Show an empty cart page if there are no orders available
                        return EmptyCartPage(
                          onClick: () {},
                        );
                      } else {
                        return ListView.builder(
                          itemCount:
                              remaningOrderController.productQuantities.length,
                          itemBuilder: (context, index) {
                            final productQuantity = remaningOrderController
                                .productQuantities[index];
                            return ListTileContainer(
                              name: productQuantity.productName,
                              quantit: productQuantity.totalQuantity,
                            );
                          },
                        );
                      }
                    }
                  })))
        ],
      ),
    );
  }
}

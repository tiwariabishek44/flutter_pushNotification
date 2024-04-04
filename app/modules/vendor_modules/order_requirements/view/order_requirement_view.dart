import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:merocanteen/app/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:merocanteen/app/models/order_response.dart';
import 'package:merocanteen/app/modules/common/login/login_controller.dart';
import 'package:merocanteen/app/modules/vendor_modules/order_requirements/order_requirement_controller.dart';
import 'package:merocanteen/app/modules/vendor_modules/orders_checkout/veodor_order_controller.dart';
import 'package:merocanteen/app/modules/vendor_modules/widget/list_tile_contailer.dart';
import 'package:merocanteen/app/widget/empty_cart_page.dart';
import 'package:merocanteen/app/widget/loading_screen.dart';
import 'package:intl/intl.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderRequirement extends StatefulWidget {
  @override
  State<OrderRequirement> createState() => _OrderRequirementState();
}

class _OrderRequirementState extends State<OrderRequirement> {
  final orderRequestController = Get.put(OrderRequestContoller());

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
    orderRequestController.fetchMeal(selectedIndex.toInt(), dat);
    // 1 am or later
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();

    NepaliDateTime nepaliDateTime = NepaliDateTime.fromDateTime(currentDate);

    String formattedDate =
        DateFormat('dd/MM/yyyy\'', 'en').format(nepaliDateTime);
    orderRequestController.date.value = formattedDate;

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
                "Order Requirement ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              formattedDate == dat
                  ? Text(
                      dat + "  (Today)", // Display Nepali date in the app bar
                      style: TextStyle(fontSize: 16),
                    )
                  : Text(
                      dat +
                          "  (Tomorrow)", // Display Nepali date in the app bar
                      style: TextStyle(fontSize: 16),
                    ),
            ],
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Today'),
                  value: 'Today',
                ),
                PopupMenuItem(
                  child: Text('Tomorrow'),
                  value: 'Tomorrow',
                ),
              ];
            },
            onSelected: (value) {
              // Handle the selected option
              if (value == 'Today') {
                // Do something for Option 1
                setState(() {
                  dat = DateFormat('dd/MM/yyyy\'', 'en').format(nepaliDateTime);
                  orderRequestController.fetchMeal(selectedIndex.toInt(), dat);
                });
              } else if (value == 'Tomorrow') {
                NepaliDateTime tomorrow = nepaliDateTime.add(Duration(days: 1));
                setState(() {
                  dat = DateFormat('dd/MM/yyyy\'', 'en').format(tomorrow);
                  orderRequestController.fetchMeal(selectedIndex.toInt(), dat);
                });
                // Do something for Option 2
              }
            },
          ),
        ],
      ),
      // Add the rest of your app content here

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
                  itemCount: orderRequestController.timeSlots.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            orderRequestController.fetchMeal(
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
                              orderRequestController.timeSlots[index],
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
                  if (orderRequestController.isLoading.value) {
                    // Show a loading screen while data is being fetched
                    return LoadingScreen();
                  } else {
                    if (orderRequestController
                                .requirmentResponse.value.response ==
                            null ||
                        orderRequestController
                            .requirmentResponse.value.response!.isEmpty) {
                      // Show an empty cart page if there are no orders available
                      return EmptyCartPage(
                        onClick: () {},
                      );
                    } else {
                      return Obx(() {
                        if (orderRequestController.isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (orderRequestController
                                  .requirmentResponse.value.response!.length ==
                              0) {
                            return Container(
                              color: AppColors.iconColors,
                            );
                          } else {
                            return ListView.builder(
                              itemCount: orderRequestController
                                  .productQuantities.length,
                              itemBuilder: (context, index) {
                                final productQuantity = orderRequestController
                                    .productQuantities[index];
                                return ListTileContainer(
                                  name: productQuantity.productName,
                                  quantit: productQuantity.totalQuantity,
                                );
                              },
                            );
                          }
                        }
                      });
                    }
                  }
                }),
              )),
        ],
      ),
    );
  }
}

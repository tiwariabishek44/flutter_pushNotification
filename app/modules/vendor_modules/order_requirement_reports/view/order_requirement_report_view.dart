import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:merocanteen/app/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:merocanteen/app/config/style.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:merocanteen/app/modules/vendor_modules/order_requirements/order_requirement_controller.dart';
import 'package:merocanteen/app/modules/vendor_modules/widget/list_tile_contailer.dart';
import 'package:merocanteen/app/widget/custom_app_bar.dart';
import 'package:merocanteen/app/widget/empty_cart_page.dart';
import 'package:merocanteen/app/widget/loading_screen.dart';
import 'package:intl/intl.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderRequirementReport extends StatefulWidget {
  @override
  State<OrderRequirementReport> createState() => _OrderRequirementReportState();
}

class _OrderRequirementReportState extends State<OrderRequirementReport> {
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

  Future<void> selectDate(BuildContext context) async {
    final NepaliDateTime? picked = await picker.showMaterialDatePicker(
      context: context,
      initialDate: NepaliDateTime.now(),
      firstDate: NepaliDateTime(2000),
      lastDate: NepaliDateTime(2090),
      initialDatePickerMode: DatePickerMode.day,
    );

    if (picked != null) {
      setState(() {
        dat = DateFormat('dd/MM/yyyy\'', 'en').format(picked);
      });
      orderRequestController.fetchMeal(0, dat);
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();

    NepaliDateTime nepaliDateTime = NepaliDateTime.fromDateTime(currentDate);

    String formattedDate =
        DateFormat('dd/MM/yyyy\'', 'en').format(nepaliDateTime);
    orderRequestController.date.value = formattedDate;

    return Scaffold(
      backgroundColor:
          AppColors.backgroundColor, // Make scaffold background transparent

      appBar: CustomAppBar(
        title: 'Order Requirement Report',
      ),
      body: Padding(
        padding: AppPadding.screenHorizontalPadding,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  selectDate(context);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(221, 149, 87, 7),
                  ),
                  height: 6.h,
                  child: Center(
                      child: Text(
                    'Select the date ',
                    style: AppStyles.buttonText,
                  )),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Divider(
                height: 1.h,
                thickness: 1.h,
                color: Color.fromARGB(255, 220, 216, 216),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Report Of : $dat',
                        style: AppStyles.topicsHeading,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(() {
                          if (orderRequestController.isLoading.value) {
                            // Show a loading screen while data is being fetched
                            return LoadingScreen();
                          } else {
                            if (orderRequestController
                                        .requirmentResponse.value.response ==
                                    null ||
                                orderRequestController.requirmentResponse.value
                                    .response!.isEmpty) {
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
                                  if (orderRequestController.requirmentResponse
                                          .value.response!.length ==
                                      0) {
                                    return Container(
                                      color: AppColors.iconColors,
                                    );
                                  } else {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: orderRequestController
                                          .productQuantities.length,
                                      itemBuilder: (context, index) {
                                        final productQuantity =
                                            orderRequestController
                                                .productQuantities[index];
                                        return ListTileContainer(
                                          name: productQuantity.productName,
                                          quantit:
                                              productQuantity.totalQuantity,
                                        );
                                      },
                                    );
                                  }
                                }
                              });
                            }
                          }
                        }),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Scaffold(
    //   backgroundColor: AppColors.backgroundColor,
    //   appBar: AppBar(
    //     scrolledUnderElevation: 0,
    //     title: Padding(
    //       padding: EdgeInsets.all(8.0),
    //       child: Text("Order Requirement Report ", style: AppStyles.appbar),
    //     ),
    //   ),
    //   // Add the rest of your app content here

    //   body: Column(
    //     children: [
    //       Expanded(
    //         flex: 1,
    //         child: Container(
    //           color: Colors.white,
    //           child:
    //
    // ListView.builder(
    //               scrollDirection: Axis.horizontal,
    //               shrinkWrap: true,
    //               physics: ScrollPhysics(),
    //               itemCount: orderRequestController.timeSlots.length,
    //               itemBuilder: (BuildContext context, int index) {
    //                 return Padding(
    //                   padding: const EdgeInsets.all(6.0),
    //                   child: GestureDetector(
    //                     onTap: () {
    //                       setState(() {
    //                         selectedIndex = index;
    //                         orderRequestController.fetchMeal(
    //                             selectedIndex.toInt(), dat);
    //                       });
    //                     },
    //                     child: Container(
    //                       width: 100,
    //                       decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(20),
    //                         color: selectedIndex == index
    //                             ? Color.fromARGB(255, 9, 9, 9)
    //                             : const Color.fromARGB(255, 247, 245, 245),
    //                       ),
    //                       child: Center(
    //                         child: Text(
    //                           orderRequestController.timeSlots[index],
    //                           style: TextStyle(
    //                               fontSize: 18.0,
    //                               color: selectedIndex == index
    //                                   ? AppColors.backgroundColor
    //                                   : Color.fromARGB(255, 84, 82, 82)),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 );
    //               }),
    //         ),
    //       ),
    //       Expanded(
    //           flex: 13,
    //           child:
    // Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Obx(() {
    //               if (orderRequestController.isLoading.value) {
    //                 // Show a loading screen while data is being fetched
    //                 return LoadingScreen();
    //               } else {
    //                 if (orderRequestController
    //                             .requirmentResponse.value.response ==
    //                         null ||
    //                     orderRequestController
    //                         .requirmentResponse.value.response!.isEmpty) {
    //                   // Show an empty cart page if there are no orders available
    //                   return EmptyCartPage(
    //                     onClick: () {},
    //                   );
    //                 } else {
    //                   return Obx(() {
    //                     if (orderRequestController.isLoading.value) {
    //                       return Center(
    //                         child: CircularProgressIndicator(),
    //                       );
    //                     } else {
    //                       if (orderRequestController
    //                               .requirmentResponse.value.response!.length ==
    //                           0) {
    //                         return Container(
    //                           color: AppColors.iconColors,
    //                         );
    //                       } else {
    //                         return ListView.builder(
    //                           itemCount: orderRequestController
    //                               .productQuantities.length,
    //                           itemBuilder: (context, index) {
    //                             final productQuantity = orderRequestController
    //                                 .productQuantities[index];
    //                             return ListTileContainer(
    //                               name: productQuantity.productName,
    //                               quantit: productQuantity.totalQuantity,
    //                             );
    //                           },
    //                         );
    //                       }
    //                     }
    //                   });
    //                 }
    //               }
    //             }),
    //           )),
    //     ],
    //   ),
    // );
  }
}

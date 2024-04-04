import 'dart:developer';

import 'package:get/get.dart';
import 'package:merocanteen/app/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:merocanteen/app/config/style.dart';
import 'package:merocanteen/app/models/order_response.dart';
import 'package:merocanteen/app/modules/vendor_modules/orders_holds/hold_order_controller.dart';
import 'package:merocanteen/app/modules/vendor_modules/orders_checkout/veodor_order_controller.dart';
import 'package:merocanteen/app/modules/vendor_modules/widget/empty_order.dart';
import 'package:merocanteen/app/modules/vendor_modules/widget/no_order.dart';
import 'package:merocanteen/app/widget/confirmation_dialog.dart';
import 'package:merocanteen/app/widget/customized_button.dart';
import 'package:merocanteen/app/widget/empty_cart_page.dart';
import 'package:merocanteen/app/widget/loading_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderCancel extends StatelessWidget {
  final holdOrderController = Get.put(CanteenHoldOrders());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders Hold"),
      ),
      body: Padding(
        padding: AppPadding.screenHorizontalPadding,
        child: Column(
          children: [
            Container(
                color: Colors.white,
                child: TextField(
                  onChanged: (value) {
                    log(value);
                    holdOrderController.fetchOrders(value!);
                  },
                  controller: holdOrderController.groupcod,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xffE8ECF4), width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xffE8ECF4), width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: const Color(0xffE8ECF4),
                    filled: true,
                    hintText: 'Group Code',
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )),
            SizedBox(
              height: 2.h,
            ),
            Expanded(
                flex: 9,
                child: Obx(() {
                  if (!holdOrderController.isOrderFetch.value) {
                    return EmptyOrderPage();
                  } else {
                    if (holdOrderController.isloading.value ||
                        holdOrderController.holdLoading.value)
                      return LoadingScreen();
                    else {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: holdOrderController
                                  .orderResponse.value.response!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 2.0.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ConfirmationDialog(
                                            isbutton: true,
                                            heading: 'Hold Order',
                                            subheading:
                                                "Be Sure This  meal will not be prepared in the canteen.",
                                            firstbutton: "Agree",
                                            secondbutton: 'Cancel',
                                            onConfirm: () {
                                              holdOrderController.holdUserOrder(
                                                  context,
                                                  holdOrderController
                                                      .orderResponse
                                                      .value
                                                      .response![index]
                                                      .id,
                                                  holdOrderController
                                                      .orderResponse
                                                      .value
                                                      .response![index]
                                                      .date);

                                              // Perform actions when the user agrees
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 17.h,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              color: Colors
                                                  .white, // Add a background color
                                            ),
                                            height: 15.h,
                                            width: 30.w,
                                            child: ClipRRect(
                                              // Use ClipRRect to ensure that the curved corners are applied
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              child: CachedNetworkImage(
                                                imageUrl: holdOrderController
                                                        .orderResponse
                                                        .value
                                                        .response![index]
                                                        .productImage ??
                                                    '',
                                                fit: BoxFit.cover,
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Icon(Icons.error_outline,
                                                        size: 40),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                holdOrderController
                                                    .orderResponse
                                                    .value
                                                    .response![index]
                                                    .productName,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppStyles.listTileTitle,
                                              ),
                                              Text(
                                                'Rs.${holdOrderController.orderResponse.value.response![index].price.toStringAsFixed(2)}',
                                                style: AppStyles.listTileTitle,
                                              ),
                                              Text(
                                                  '${holdOrderController.orderResponse.value.response![index].customer}',
                                                  style: AppStyles
                                                      .listTilesubTitle),
                                              Text(
                                                '${holdOrderController.orderResponse.value.response![index].date}' +
                                                    '(${holdOrderController.orderResponse.value.response![index].mealtime})',
                                                style:
                                                    AppStyles.listTilesubTitle,
                                              ),
                                              Text(
                                                '${holdOrderController.orderResponse.value.response![index].quantity}-plate',
                                                style:
                                                    AppStyles.listTilesubTitle,
                                              ),
                                              SizedBox(
                                                height: 0.4.h,
                                              ),
                                              holdOrderController
                                                              .orderResponse
                                                              .value
                                                              .response![index]
                                                              .holdDate !=
                                                          '' ||
                                                      holdOrderController
                                                          .orderResponse
                                                          .value
                                                          .response![index]
                                                          .holdDate
                                                          .isNotEmpty
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: Colors.green,
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 0.1.h,
                                                                horizontal:
                                                                    2.w),
                                                        child: Text(
                                                            "Hold:${holdOrderController.orderResponse.value.response![index].holdDate}",
                                                            style: AppStyles
                                                                .listTilesubTitle),
                                                      ),
                                                    )
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: Color.fromARGB(
                                                            255, 216, 188, 27),
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 0.1.h,
                                                                horizontal:
                                                                    2.w),
                                                        child: Text(
                                                          "Regular",
                                                          style: AppStyles
                                                              .listTilesubTitle,
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  }
                })),
          ],
        ),
      ),
    );
  }
}

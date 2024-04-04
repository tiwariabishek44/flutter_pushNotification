import 'dart:developer';

import 'package:get/get.dart';
import 'package:merocanteen/app/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:merocanteen/app/config/style.dart';
import 'package:merocanteen/app/modules/vendor_modules/orders_checkout/veodor_order_controller.dart';
import 'package:merocanteen/app/modules/vendor_modules/widget/empty_order.dart';

import 'package:merocanteen/app/widget/customized_button.dart';
import 'package:merocanteen/app/widget/loading_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderCheckoutPage extends StatelessWidget {
  final ordercontroller = Get.put(VendorOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          "Orders Checkout",
          style: AppStyles.appbar,
        ),
        actions: [
          Obx(
            () => GestureDetector(
              onTap: () {
                if (ordercontroller.isgroup.value)
                  ordercontroller.isgroup.value =
                      !ordercontroller.isgroup.value;
              },
              child: Container(
                padding: EdgeInsets.all(8), // Adjust padding as needed
                decoration: BoxDecoration(
                  color: ordercontroller.isgroup.value
                      ? AppColors.greyColor
                      : Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  size: 19.sp,
                  color: ordercontroller.isgroup.value
                      ? AppColors.iconColors
                      : Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 2.w), // Add spacing between icons
          Obx(
            () => GestureDetector(
              onTap: () {
                if (!ordercontroller.isgroup.value)
                  ordercontroller.isgroup.value =
                      !ordercontroller.isgroup.value;
              },
              child: Container(
                padding: EdgeInsets.all(8), // Adjust padding as needed
                decoration: BoxDecoration(
                  color: ordercontroller.isgroup.value
                      ? AppColors.iconColors
                      : Color.fromARGB(255, 206, 201, 201),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.people,
                  size: 19.sp,
                  color: ordercontroller.isgroup.value
                      ? AppColors.backgroundColor
                      : const Color.fromARGB(255, 19, 17, 17),
                ),
              ),
            ),
          ),
          SizedBox(width: 5.w), // Add spacing between icons
        ],
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
                    ordercontroller.fetchOrders(value!);
                  },
                  controller: ordercontroller.groupcod,
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
              height: 1.h,
            ),
            Expanded(
                flex: 9,
                child: Obx(() {
                  if (!ordercontroller.isOrderFetch.value) {
                    return EmptyOrderPage();
                  } else {
                    if (ordercontroller.isloading.value ||
                        ordercontroller.checkoutLoading.value)
                      return LoadingScreen();
                    else {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 10.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: ScrollPhysics(),
                                itemCount: ordercontroller
                                    .orderResponse.value.response!.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 1.w),
                                      child: Container(
                                        height: 10.h,
                                        width: 10.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl: ordercontroller
                                                    .orderResponse
                                                    .value
                                                    .response![index]
                                                    .customerImage ??
                                                '',
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, url, error) => Icon(
                                                    Icons.error_outline,
                                                    size: 40),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            const Divider(
                              height: 0.5,
                              thickness: 0.5,
                              color: Color.fromARGB(221, 93, 90, 90),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: ordercontroller
                                  .orderResponse.value.response!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 2.0.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();

                                      if (!ordercontroller.isgroup.value) {
                                        // Show the dialog when the button is pressed
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              elevation: 0,
                                              title: Text('Order Checkout'),
                                              content: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize
                                                    .min, // Set to min to adjust height to content
                                                children: [
                                                  Text(
                                                    'Customer: ${ordercontroller.orderResponse.value.response![index].customer}',
                                                    style:
                                                        AppStyles.listTileTitle,
                                                  ),
                                                  Text(
                                                      'Item: ${ordercontroller.orderResponse.value.response![index].productName}',
                                                      style: AppStyles
                                                          .listTileTitle),
                                                ],
                                              ),
                                              contentPadding: EdgeInsets.symmetric(
                                                  vertical: 20,
                                                  horizontal:
                                                      24), // Adjust padding as needed
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    // Close the dialog

                                                    ordercontroller
                                                        .checkoutSingleOrder(
                                                      context,
                                                      ordercontroller
                                                          .orderResponse
                                                          .value
                                                          .response![index]
                                                          .id,
                                                    );
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                    padding:
                                                        EdgeInsets.all(12.0),
                                                    child: const Text(
                                                      "Checkout",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );

                                        // showDialog(
                                        //   context: context,
                                        //   builder: (BuildContext context) {
                                        //     return ConfirmationDialog(
                                        //       isbutton: true,
                                        //       heading: 'Order Checkout',
                                        //       subheading:
                                        //           "Checkout ${ordercontroller.orderResponse.value.response![index].productName}",
                                        //       firstbutton:
                                        //           "Checkout (${ordercontroller.orderResponse.value.response![index].customer})",
                                        //       secondbutton: 'Cancel',
                                        //       onConfirm: () {
                                        //         // Perform actions when the user agrees
                                        //         FocusScope.of(context)
                                        //             .unfocus();
                                        //         ordercontroller
                                        //             .checkoutSingleOrder(
                                        //           context,
                                        //           ordercontroller
                                        //               .orderResponse
                                        //               .value
                                        //               .response![index]
                                        //               .id,
                                        //         );
                                        //         Get.back();
                                        //       },
                                        //     );
                                        //   },
                                        // );
                                      }
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
                                            height: 20.h,
                                            width: 30.w,
                                            child: ClipRRect(
                                              // Use ClipRRect to ensure that the curved corners are applied
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              child: CachedNetworkImage(
                                                imageUrl: ordercontroller
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
                                                ordercontroller
                                                    .orderResponse
                                                    .value
                                                    .response![index]
                                                    .productName,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppStyles.listTileTitle,
                                              ),
                                              Text(
                                                'Rs.${ordercontroller.orderResponse.value.response![index].price.toStringAsFixed(2)}',
                                                style: AppStyles.listTileTitle,
                                              ),
                                              Text(
                                                  '${ordercontroller.orderResponse.value.response![index].customer}',
                                                  style: AppStyles
                                                      .listTilesubTitle),
                                              Text(
                                                '${ordercontroller.orderResponse.value.response![index].date}' +
                                                    '(${ordercontroller.orderResponse.value.response![index].mealtime})',
                                                style:
                                                    AppStyles.listTilesubTitle,
                                              ),
                                              Text(
                                                '${ordercontroller.orderResponse.value.response![index].quantity}-plate',
                                                style:
                                                    AppStyles.listTilesubTitle,
                                              ),
                                              SizedBox(
                                                height: 0.4.h,
                                              ),
                                              ordercontroller
                                                              .orderResponse
                                                              .value
                                                              .response![index]
                                                              .holdDate !=
                                                          '' ||
                                                      ordercontroller
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
                                                            "Hold:${ordercontroller.orderResponse.value.response![index].holdDate}",
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
                            Obx(() => ordercontroller.isgroup.value
                                ? CustomButton(
                                    text:
                                        "Check Out(${ordercontroller.groupcod.text})",
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      ordercontroller.checkoutGroupOrder(
                                        context,
                                        ordercontroller.groupcod.text,
                                      );
                                    },
                                    isLoading:
                                        ordercontroller.checkoutLoading.value)
                                : SizedBox())
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

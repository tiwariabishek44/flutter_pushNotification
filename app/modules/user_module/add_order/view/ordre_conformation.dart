import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:merocanteen/app/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merocanteen/app/config/style.dart';
import 'package:merocanteen/app/eSewa/esewa_function.dart';
import 'package:merocanteen/app/models/product_model.dart';
import 'package:merocanteen/app/models/users_model.dart';
import 'package:merocanteen/app/modules/user_module/add_order/add_product_controller.dart';
import 'package:merocanteen/app/modules/user_module/orders/orders_controller.dart';
import 'package:merocanteen/app/modules/user_module/group/group_controller.dart';
import 'package:merocanteen/app/widget/loading_screen.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderConfirmationDialog extends StatefulWidget {
  final String date;
  final Product product;
  final UserDataResponse user;

  OrderConfirmationDialog(
      {required this.date, required this.product, required this.user, Key? key})
      : super(key: key);

  @override
  State<OrderConfirmationDialog> createState() =>
      _OrderConfirmationDialogState();
}

class _OrderConfirmationDialogState extends State<OrderConfirmationDialog> {
  final groupcontroller = Get.put(GroupController());
  final addproductController = Get.put(AddProductController());
  late final Esewa esewa;
  List<String> timeSlots = [
    '8:30',
    '9:30',
    '11:30',
    '12:30',
    '1:30',
  ];

  bool isMealTimeSelectionVisible = true; // Add this variable

  @override
  void initState() {
    super.initState();
    esewa = Esewa(addproductController);

    // checkTimeAndSetVisibility();
  }

  // void checkTimeAndSetVisibility() {
  //   DateTime currentDate = DateTime.now();
  //   int currentHour = currentDate.hour;

  //   if ((currentHour >= 16 && currentHour <= 24) ||
  //       (currentHour >= 1 && currentHour < 8)) {
  //     // After 4 pm but not after 8 am of the next day
  //     setState(() {
  //       isMealTimeSelectionVisible = true;
  //     });
  //   }
  // }

  int selectedIndex = -1;
  void showNoSelectionMessage() {
    Get.snackbar(
      'No Time Slot Selected',
      'Please select a time slot',
      backgroundColor: Colors.red, // Set your desired background color here
      colorText: Colors.white, // Set the text color
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    NepaliDateTime nepaliDateTime = NepaliDateTime.fromDateTime(currentDate);
    String formattedDate = DateFormat.yMd().add_jm().format(nepaliDateTime);

    int currentHour = currentDate.hour;

    String dateMessage;
    return Dialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.bottomCenter,
      insetPadding: EdgeInsets.zero,
      child: Container(
        height: isMealTimeSelectionVisible
            ? 80.h
            : MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: AppPadding.screenHorizontalPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(() {
                if (groupcontroller
                    .groupResponse.value.response!.first.groupCode.isEmpty) {
                  return LoadingScreen();
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Group Code : ', style: AppStyles.subtitleStyle),
                          Text(
                              groupcontroller.groupResponse.value.response!
                                  .first.groupCode,
                              style: AppStyles.titleStyle)
                        ],
                      ),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Your order is under group ${groupcontroller.groupResponse.value.response!.first.groupName}',
                              style: AppStyles.listTilesubTitle,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              }),
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 15.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: const Color.fromARGB(
                            255, 184, 173, 173), // Add a background color
                      ),
                      height: 15.h,
                      width: 30.w,
                      child: ClipRRect(
                        // Use ClipRRect to ensure that the curved corners are applied
                        borderRadius: BorderRadius.circular(7),
                        child: CachedNetworkImage(
                          imageUrl: widget.product.image ?? '',
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error_outline, size: 40),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.listTileTitle,
                          ),
                          Text(
                            "Quantity:1-plate",
                            style: AppStyles.listTilesubTitle,
                          ),
                          Text('RS.${widget.product.price}',
                              style: AppStyles.listTilesubTitle),
                          Text(
                            "For: " + widget.date,
                            style: AppStyles.listTilesubTitle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              isMealTimeSelectionVisible
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Meal Time:-  ",
                          style: AppStyles.titleStyle,
                        ),
                        SizedBox(height: 2.h),
                        Container(
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 8.0,
                                    mainAxisSpacing: 8.0,
                                    childAspectRatio: 3),
                            itemCount: timeSlots.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // setState(() {
                                  //   selectedIndex = index;
                                  //   orderController.mealTime.value =
                                  //       timeSlots[selectedIndex];
                                  // });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.secondaryColor),
                                    borderRadius: BorderRadius.circular(10),
                                    color: selectedIndex == index
                                        ? Color.fromARGB(255, 187, 188, 189)
                                        : const Color.fromARGB(
                                            255, 247, 245, 245),
                                  ),
                                  child: Center(
                                    child: Text(
                                      timeSlots[index],
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color:
                                              Color.fromARGB(255, 84, 82, 82)),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 2.h),
                        topicRow(
                            'Subtotal', "Rs. ${widget.product.price.toInt()}"),
                        topicRow('Platform Fee', 'Rs.1'),
                        topicRow('Grand Total',
                            'Rs. ${widget.product.price.toInt() + 1}'),
                        Obx(() => GestureDetector(
                              onTap: () {
                                esewa.pay(context,
                                    customerImage: widget.user.profilePicture,
                                    mealtime: "8:30",
                                    classs: widget.user.classes,
                                    date: widget.date,
                                    checkout: 'false',
                                    customer: widget.user.name,
                                    groupcod: groupcontroller.groupResponse
                                        .value.response!.first.groupCode,
                                    groupid: widget.user.groupid,
                                    cid: widget.user.userid,
                                    productName: widget.product.name,
                                    price: widget.product.price + 1,
                                    quantity: 1,
                                    productImage: widget.product.image);

                                // addproductController.addItemToOrder(
                                // context,
                                //   mealtime: "8:30",
                                //   classs: widget.user.classes,
                                //   date: widget.date,
                                //   checkout: 'false',
                                //   customer: widget.user.name,
                                //   groupcod: groupcontroller.groupResponse
                                //       .value.response!.first.groupCode,
                                //   groupid: widget.user.groupid,
                                //   cid: widget.user.userid,
                                //   productName: widget.product.name,
                                //   price: widget.product.price,
                                //   quantity: 1,
                                //   productImage: widget.product.image);
                              },

                              // () {
                              //   // if (selectedIndex == -1) {
                              //   //   showNoSelectionMessage();
                              //   // } else {

                              //   // }
                              // },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 1,
                                height: 6.h,
                                decoration: BoxDecoration(
                                  color: AppColors.iconColors,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                    child: addproductController.isLoading.value
                                        ? CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: AppColors.backgroundColor,
                                          )
                                        : Text(
                                            'Confirm',
                                            style: AppStyles.buttonText,
                                          )),
                              ),
                            )),
                        SizedBox(
                          height: 1.3.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 1,
                            height: 6.h,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 238, 235, 235),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Order Time is schedule from 4 pm to 8 am",
                          style: AppStyles.listTileTitle,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget topicRow(String topic, String subtopic) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            topic,
            style: AppStyles.topicsHeading,
          ),
          SizedBox(width: 8), //  Add spacing between topic and subtopic
          Text(subtopic, style: AppStyles.listTilesubTitle1),
        ],
      ),
    );
  }
}

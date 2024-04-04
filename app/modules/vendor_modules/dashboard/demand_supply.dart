import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merocanteen/app/config/colors.dart';
import 'package:merocanteen/app/config/style.dart';
import 'package:merocanteen/app/modules/vendor_modules/class_wise_analytics/class_reoprt_controller.dart';
import 'package:merocanteen/app/modules/vendor_modules/dashboard/salse_controller.dart';
import 'package:merocanteen/app/widget/empty_cart_page.dart';
import 'package:merocanteen/app/widget/loading_screen.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DemandSupply extends StatelessWidget {
  final salesController = Get.put(SalsesController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () {
            if (salesController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (salesController.salseQuantity.value.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Image.asset(
                          'assets/empty.png', // Replace with your image asset path
                          width: 200, // Adjust image width as needed
                          height: 200, // Adjust image height as needed
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 8),
                        child: Text(
                          'No Orders Yet',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: salesController.salseQuantity.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 2.0.h),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color.fromARGB(
                                      255, 225, 225, 225))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: salesController
                                            .salseQuantity[index].image ??
                                        '', // Use a default empty string if URL is null
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error_outline,
                                      size: 40,
                                    ), // Placeholder icon for error
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                    '${salesController.salseQuantity[index].productName}',
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                    style: AppStyles.listTileTitle),
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Text(
                                    'Sales: ${salesController.salseQuantity[index].totalQuantity} -Plate',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 35, 68, 68),
                                    ),
                                  ),
                                  Text(
                                    'Rs: ${salesController.salseQuantity[index].price}',
                                    style: AppStyles.titleStyle,
                                  ),
                                ],
                              )
                            ]),
                          ),
                        ),
                      );
                    });
              }
            }
          },
        ),
      ],
    );
  }
}

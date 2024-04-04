import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:merocanteen/app/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:merocanteen/app/config/style.dart';
import 'package:merocanteen/app/modules/vendor_modules/sales_report/salse_report_controller.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:merocanteen/app/modules/vendor_modules/order_requirements/order_requirement_controller.dart';
import 'package:merocanteen/app/modules/vendor_modules/widget/list_tile_contailer.dart';
import 'package:merocanteen/app/widget/custom_app_bar.dart';
import 'package:merocanteen/app/widget/empty_cart_page.dart';
import 'package:merocanteen/app/widget/loading_screen.dart';
import 'package:intl/intl.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SalseReportView extends StatefulWidget {
  @override
  State<SalseReportView> createState() => _SalseReportViewState();
}

class _SalseReportViewState extends State<SalseReportView> {
  final salesController = Get.put(SalsesReportController());

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
      dat = DateFormat('dd/MM/yyyy\'', 'en').format(nepaliDateTime);
    });
    salesController.fetchSalesORders(dat);
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
      salesController.fetchSalesORders(dat);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.backgroundColor, // Make scaffold background transparent

      appBar: const CustomAppBar(
        title: 'Salse Report',
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
                    color: const Color.fromARGB(221, 149, 87, 7),
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
                        child: Obx(
                          () {
                            if (salesController.isLoading.value) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              if (salesController.salesOrder.value.isEmpty) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Image.asset(
                                          'assets/empty.png', // Replace with your image asset path
                                          width:
                                              200, // Adjust image width as needed
                                          height:
                                              200, // Adjust image height as needed
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18.0, top: 8),
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
                                    itemCount: salesController
                                        .totalSalesPerOrders.length,
                                    itemBuilder: (context, index) {
                                      String productName = salesController
                                          .totalSalesPerOrders.keys
                                          .elementAt(index);
                                      int totalSalesOrders =
                                          salesController.totalSalesPerOrders[
                                                  productName] ??
                                              0;
                                      double priceRate = salesController
                                              .salesOrder[productName]
                                              ?.first
                                              .price ??
                                          0;

                                      String productImage = salesController
                                              .salesOrder[productName]
                                              ?.first
                                              .productImage ??
                                          '';
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 2.0.h),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    imageUrl: productImage ??
                                                        '', // Use a default empty string if URL is null
                                                    fit: BoxFit.cover,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(
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
                                                child: Text('$productName',
                                                    overflow: TextOverflow.clip,
                                                    maxLines: 2,
                                                    style: AppStyles
                                                        .listTileTitle),
                                              ),
                                              Spacer(),
                                              Column(
                                                children: [
                                                  Text(
                                                    'Sales: $totalSalesOrders -Plate',
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color.fromARGB(
                                                          255, 35, 68, 68),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Rs: ${priceRate * totalSalesOrders}',
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
  }
}

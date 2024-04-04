import 'package:get/get.dart';
import 'package:merocanteen/app/config/colors.dart';
import 'package:merocanteen/app/models/product_model.dart';
import 'package:merocanteen/app/modules/user_module/orders/orders_controller.dart';
import 'package:merocanteen/app/modules/vendor_modules/menue/price_update_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:merocanteen/app/widget/custom_app_bar.dart';
import 'package:merocanteen/app/widget/customized_button.dart';
import 'package:merocanteen/app/widget/customized_textfield.dart';
import 'package:merocanteen/app/widget/confirmation_dialog.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PriceUpdatePage extends StatelessWidget {
  final Product product;

  PriceUpdatePage({
    super.key,
    required this.product,
  });
  OrderController cartController = Get.find<OrderController>();
  final priceController = Get.put(PriceUpdateController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: CachedNetworkImage(
                              imageUrl: product.image ??
                                  '', // Use a default empty string if URL is null
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Icon(
                                  Icons.error_outline,
                                  size: 40), // Placeholder icon for error
                            ),
                          ),

                          // Add detailed description
                          // ... other product details and add to cart button
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name, // Replace with actual product name
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            Text(
                              "Rs.${product.price}",
                              style: TextStyle(
                                  color: Colors.red.shade200,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ), // Replace with actual price
                            SizedBox(
                              height: 20,
                            ),
                            Form(
                              key: priceController.priceFormKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      validator: priceController.priceValidator,
                                      controller: priceController.price,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.money,
                                            color: AppColors.secondaryColor,
                                            size: 30,
                                          ),
                                          onPressed: () {},
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: AppColors.secondaryColor,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: AppColors.secondaryColor,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        fillColor:
                                            Color.fromARGB(255, 255, 255, 255),
                                        filled: true,
                                        labelText: 'Enter the latest Price',
                                        labelStyle: TextStyle(
                                            color: AppColors.secondaryColor),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // CustomizedButton(
                                  //   onPressed: () {
                                  //     FocusScope.of(context).unfocus();
                                  //     priceController.priceSubmit();
                                  //   },
                                  //   buttonText: "Continue",
                                  //   buttonColor: Colors.black,
                                  //   textColor: Colors.white,
                                  // ),
                                ],
                              ),
                            ),
                          ],
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

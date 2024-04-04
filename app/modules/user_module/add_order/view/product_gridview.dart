import 'dart:developer';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:merocanteen/app/config/colors.dart';
import 'package:merocanteen/app/config/style.dart';
import 'package:merocanteen/app/modules/common/login/login_controller.dart';
import 'package:merocanteen/app/modules/user_module/add_order/add_product_controller.dart';
import 'package:merocanteen/app/modules/user_module/home/product_controller.dart';
import 'package:merocanteen/app/modules/user_module/group/group_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:merocanteen/app/modules/user_module/home/view/product_details_view.dart';
import 'package:shimmer/shimmer.dart';

class ProductGrid extends StatelessWidget {
  final String dat;
  ProductGrid({Key? key, required this.dat}) : super(key: key);

  final logincontroller = Get.put(LoginController());
  final productContorller = Get.put(ProductController());
  final groupcontroller = Get.put(GroupController());
  final addproductController = Get.put(AddProductController());

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: productContorller.allProductResponse.value.response!.length,
      itemBuilder: (context, index) {
        final product =
            productContorller.allProductResponse.value.response![index];
        if (product.active == true) {
          // Added condition to check if product is active
          return GestureDetector(
            onTap: () async {
              Get.to(() => ProductDetailsPage(
                    dat: dat,
                    product: product,
                    user:
                        logincontroller.userDataResponse.value.response!.first,
                  ));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.lightColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Opacity(
                            opacity: 0.8,
                            child: Shimmer.fromColors(
                              baseColor: Colors.black12,
                              highlightColor: Colors.red,
                              child: Container(),
                            ),
                          ),
                          imageUrl: product.image ?? '',
                          fit: BoxFit.fill,
                          width: double.infinity,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error_outline, size: 40),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${product.name}",
                            style: AppStyles.listTileTitle,
                          ),
                          Text(
                            "Rs ${product.price.toInt()}/plate",
                            style: AppStyles.listTilesubTitle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return SizedBox(); // If the product is not active, return an empty SizedBox
        }
      },
    );
  }
}

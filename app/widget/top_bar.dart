import 'package:cached_network_image/cached_network_image.dart';
import 'package:merocanteen/app/config/style.dart';
import 'package:merocanteen/app/modules/common/login/login_controller.dart';
import 'package:merocanteen/app/modules/user_module/group/view/group.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merocanteen/app/widget/custom_loging_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class CustomTopBar extends StatelessWidget implements PreferredSizeWidget {
  final logincontroller = Get.put(LoginController());

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Obx(() {
            if (logincontroller.isFetchLoading.value) {
              return LoadingWidget();
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi,${logincontroller.userDataResponse.value.response!.first.name}",
                          textAlign: TextAlign
                              .center, // Centers text within the container
                          style: AppStyles.appbar,
                        ),
                        Text(
                          logincontroller
                              .userDataResponse.value.response!.first.classes,
                          textAlign: TextAlign
                              .center, // Centers text within the container
                          style: AppStyles.listTilesubTitle1,
                        )
                      ],
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: CircleAvatar(
                        radius: 22.sp,
                        backgroundColor: Colors.white,
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
                          imageUrl: logincontroller.userDataResponse.value
                                  .response!.first.profilePicture ??
                              '',
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle, // Apply circular shape
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          fit: BoxFit.fill,
                          width: double.infinity,
                          errorWidget: (context, url, error) => CircleAvatar(
                            radius: 21.4.sp,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 224, 218, 218),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          })),
    );
  }
}

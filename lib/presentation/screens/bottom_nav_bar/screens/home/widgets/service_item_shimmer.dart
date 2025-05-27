// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/freelancer_item_shimmer.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';
import 'package:irhebo/presentation/widgets/decorated_icon.dart';

class ServiceItemShimmer extends StatelessWidget {
  const ServiceItemShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 1.99 * (w / 100), vertical: 2.48 * (w / 100)),
      child: Container(
        decoration: Get.find<AppController>().darkMode
            ? null
            : AppDecoration.getDecorationWithShadow(radius: 18),
        child: Stack(
          children: [
            AppLoading(
              width: 57.46 * (w / 100),
              height: 63.38 * (w / 100),
              radius: 18,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 57.46 * (w / 100),
                height: 37.3 * (w / 100),
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: AppDecoration.getDecorationWithRadius(
                      color: Get.find<AppController>().darkMode
                          ? AppDarkColors.darkContainer2
                          : Colors.white,
                      radius: 18),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.48 * (w / 100)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppLoading(
                              height: 3 * (w / 100),
                              width: 45.16 * (w / 100),
                              radius: 5,
                            ),
                            SizedBox(
                              height: 3 * (w / 100),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppLoading(
                                  height: 3 * (w / 100),
                                  width: 10.16 * (w / 100),
                                  radius: 5,
                                ),
                                AppLoading(
                                  height: 3 * (w / 100),
                                  width: 10.16 * (w / 100),
                                  radius: 5,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: AppDarkColors.pureWhite.withOpacity(0.2),
                      ),
                      FreelancerItemShimmer()
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 2.98 * (w / 100),
              right: 2.98 * (w / 100),
              child: DecoratedIcon(
                width: 8.2 * (w / 100),
                height: 8.2 * (w / 100),
                padding: 1.69 * (w / 100),
                color: Get.find<AppController>().darkMode
                    ? AppDarkColors.primaryColor.withOpacity(0.31)
                    : AppLightColors.secondary,
                imagePath: AppIcons.emptyHeart,
              ),
            )
          ],
        ),
      ),
    );
  }
}

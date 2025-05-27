import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/freelancer_item_shimmer.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';
import 'package:irhebo/presentation/widgets/rating_stars.dart';

class RequestDetailsShimmer extends StatelessWidget {
  const RequestDetailsShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.22 * (w / 100),
                ),
                Container(
                  decoration: AppDecoration.getDecorationWithRadius(
                      radius: 16,
                      color: Get.find<AppController>().darkMode
                          ? AppDarkColors.dark3
                          : AppLightColors.primaryColor.withOpacity(0.06)),
                  padding: EdgeInsets.symmetric(
                      horizontal: 3.37 * (w / 100), vertical: 3.47 * (w / 100)),
                  child: Column(
                    children: [
                      FreelancerItemShimmer(
                        isReview: true,
                      ),
                      RatingStars(count: 0),
                    ],
                  ),
                ),
                SizedBox(
                  height: 7.71 * (w / 100),
                ),
                AppLoading(
                  height: 3 * (w / 100),
                  width: 60 * (w / 100),
                  radius: 10,
                ),
                SizedBox(
                  height: 2.73 * (w / 100),
                ),
                AppLoading(
                  height: 3 * (w / 100),
                  width: 40 * (w / 100),
                  radius: 10,
                ),
                SizedBox(
                  height: 7.71 * (w / 100),
                ),
                SizedBox(
                  width: 87.5 * (w / 100),
                  child: Column(
                    children: [
                      AppLoading(
                        height: 9.2 * (w / 100),
                        width: w,
                        radius: 50,
                      ),
                      SizedBox(
                        height: 4.47 * (w / 100),
                      ),
                      Column(
                        children: [
                          for (int i = 0; i < 4; i++)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2.48 * (w / 100)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppLoading(
                                    height: 3 * (w / 100),
                                    width: 25 * (w / 100),
                                    radius: 10,
                                  ),
                                  AppLoading(
                                    height: 3 * (w / 100),
                                    width: 20 * (w / 100),
                                    radius: 10,
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                      SizedBox(
                        height: 7.96 * (w / 100),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ////
          ],
        ),
      ],
    );
  }
}

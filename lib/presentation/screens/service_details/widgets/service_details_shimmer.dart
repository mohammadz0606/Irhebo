import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/freelancer_item_shimmer.dart';
import 'package:irhebo/presentation/screens/service_details/widgets/description_shimmer.dart';
import 'package:irhebo/presentation/screens/service_details/widgets/media_item_shimmer.dart';
import 'package:irhebo/presentation/screens/service_details/widgets/review_item_shimmer.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';
import 'package:irhebo/presentation/widgets/service_details_app_bar.dart';

class ServiceDetailsShimmer extends StatelessWidget {
  const ServiceDetailsShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              AppLoading(
                width: 100 * (w / 100),
                height: 63.68 * (w / 100),
              ),
              Container(
                height: 36.32 * (w / 100),
                width: 100.2 * (w / 100),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 53.48 * (w / 100)),
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: 4.47 * (w / 100), horizontal: 3.98 * (w / 100)),
              decoration: BoxDecoration(
                  color: Get.find<AppController>().darkMode
                      ? AppDarkColors.darkScaffoldColor
                      : AppLightColors.scaffoldColor2,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(44),
                      topRight: Radius.circular(44))),
              child: Column(
                children: [
                  ///info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FreelancerItemShimmer(),
                      SizedBox(
                        height: 4.47 * (w / 100),
                      ),
                      AppLoading(
                        height: 3 * (w / 100),
                        width: 55.16 * (w / 100),
                        radius: 5,
                      ),
                      SizedBox(
                        height: 3 * (w / 100),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppLoading(
                                    height: 3 * (w / 100),
                                    width: 30.16 * (w / 100),
                                    radius: 5,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2 * (w / 100),
                              ),
                              AppLoading(
                                height: 3 * (w / 100),
                                width: 20 * (w / 100),
                                radius: 5,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AppLoading(
                                height: 3 * (w / 100),
                                width: 30 * (w / 100),
                                radius: 5,
                              ),
                              SizedBox(
                                height: 1 * (w / 100),
                              ),
                              AppLoading(
                                height: 3 * (w / 100),
                                width: 20 * (w / 100),
                                radius: 5,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.49 * (w / 100),
                      ),
                    ],
                  ),
                  Divider(
                    height: 1,
                  ),

                  /// description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DescriptionShimmer(),

                      ///media
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.48 * (w / 100)),
                            child: AppLoading(
                                height: 5 * (w / 100),
                                width: 20 * (w / 100),
                                radius: 8),
                          ),
                          MediaItemShimmer(),
                          SizedBox(
                            height: 6.21 * (w / 100),
                          ),
                          Divider(
                            height: 1,
                          )
                        ],
                      )
                      //review
                      ,
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: 2 * (w / 100)),
                              child: AppLoading(
                                  height: 5 * (w / 100),
                                  width: 20 * (w / 100),
                                  radius: 8),
                            ),
                            ReviewItemShimmer()
                          ])
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(top: 16.41 * (w / 100), child: ServiceDetailsAppBar()),
        ],
      ),
    );
  }
}

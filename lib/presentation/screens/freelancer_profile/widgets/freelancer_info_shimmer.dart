import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/screens/search/widgets/search_service_shimmer.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';
import 'package:irhebo/presentation/widgets/rating_stars.dart';

class FreelancerInfoShimmer extends StatelessWidget {
  const FreelancerInfoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: 43.48 * (w / 100)),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 4.47 * (w / 100), horizontal: 3.98 * (w / 100)),
        decoration: BoxDecoration(
            color: Get.find<AppController>().darkMode
                ? AppDarkColors.darkScaffoldColor
                : AppLightColors.scaffoldColor2,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(44), topRight: Radius.circular(44))),
        width: 100 * (w / 100),
        child: Column(
          children: [
            SizedBox(
              height: 12.9 * (w / 100),
            ),
            AppLoading(
              height: 4 * (w / 100),
              width: 20 * (w / 100),
              radius: 10,
            ),
            SizedBox(
              height: 1.74 * (w / 100),
            ),
            AppLoading(
              height: 4 * (w / 100),
              width: 30 * (w / 100),
              radius: 10,
            ),
            SizedBox(
              height: 1.74 * (w / 100),
            ),
            RatingStars(count: 0),
            SizedBox(
              height: 3.98 * (w / 100),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < 4; i++)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.62 * (w / 100)),
                    child: AppLoading(
                      width: 21 * (w / 100),
                      height: 9.2 * (w / 100),
                      radius: 50,
                    ),
                  )
              ],
            ),
            SizedBox(
              height: 5.47 * (w / 100),
            ),
            SearchServiceShimmer(
              isTherePadding: false,
            )
          ],
        ),
      ),
    );
  }
}

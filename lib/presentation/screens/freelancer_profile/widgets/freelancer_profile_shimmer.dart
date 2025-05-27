import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/screens/freelancer_profile/widgets/freelancer_info_shimmer.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';
import 'package:irhebo/presentation/widgets/service_details_app_bar.dart';

class FreelancerProfileShimmer extends StatelessWidget {
  const FreelancerProfileShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          color: Get.find<AppController>().darkMode
              ? AppDarkColors.darkCover
              : AppLightColors.primaryColor.withOpacity(0.5),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                children: [
                  AppIcon(
                    path: AppImages.pattern,
                    width: 100 * (w / 100),
                    height: 63.68 * (w / 100),
                    isSvg: false,
                  ),
                  SizedBox(
                    height: 36.32 * (w / 100),
                    width: 100.2 * (w / 100),
                  )
                ],
              ),
              FreelancerInfoShimmer(),
              Padding(
                padding: EdgeInsets.only(top: 35.27 * (w / 100)),
                child: AppLoading(
                  width: 18.9 * (w / 100),
                  height: 18.9 * (w / 100),
                  radius: 50 * (w / 100),
                ),
              ),
              Positioned(
                  top: 16.41 * (w / 100),
                  child: ServiceDetailsAppBar(
                    profile: true,
                    onTapChat: () => {},
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

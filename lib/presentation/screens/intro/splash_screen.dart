import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/presentation/screens/intro/splash_controller.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';

import '../../../app/network/end_points.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Get.find<AppController>().darkMode ? null : Colors.white,
      body: Center(
        child: AppImage(
          //imageUrl: AppImages.appLogo,
          imageUrl:
              '${AppEndpoints.media_url}storage/logo/1750084979_Irhebo_logo_page-0008.png',
          //width: 71.39 * (w / 100),
          //height: 71.39 * (w / 100),
          radius: 40,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

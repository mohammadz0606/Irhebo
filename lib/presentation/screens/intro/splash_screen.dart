import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/presentation/screens/intro/splash_controller.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Get.find<AppController>().darkMode ? null : Colors.white,
      body: Center(
        child: AppImage(
          imageUrl: AppImages.userImageUrl6,
          width: 71.39 * (w / 100),
          height: 71.39 * (w / 100),
          radius: 40,
        ),
      ),
    );
  }
}

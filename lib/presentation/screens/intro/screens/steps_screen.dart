import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/presentation/screens/intro/splash_controller.dart';
import 'package:irhebo/presentation/screens/intro/widgets/steps_bottom_bar.dart';
import 'package:irhebo/presentation/screens/intro/widgets/steps_page_view.dart';
import 'package:irhebo/presentation/screens/intro/widgets/steps_page_view_shimmer.dart';

class StepsScreen extends GetWidget<SplashController> {
  const StepsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor:
            Get.find<AppController>().darkMode ? null : Colors.white,
        body: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              controller.isLoadingSteps
                  ? StepsPageViewShimmer()
                  : StepsPageView(
                      steps: controller.steps,
                    )
            ],
          ),
        ),
        bottomNavigationBar: StepsBottomBar());
  }
}

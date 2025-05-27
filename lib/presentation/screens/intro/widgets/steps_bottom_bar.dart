// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/presentation/screens/intro/splash_controller.dart';
import 'package:irhebo/presentation/screens/intro/widgets/indicators_bar.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

class StepsBottomBar extends GetWidget<SplashController> {
  const StepsBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(
            bottom: 8.95 * (w / 100),
            right: 6.21 * (w / 100),
            left: 6.21 * (w / 100)),
        child: controller.isLoadingSteps
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 3; i++)
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0.74 * (w / 100)),
                        child: AppLoading(
                          width: 3 * (w / 100),
                          height: 3 * (w / 100),
                          radius: 50 * (w / 100),
                        ))
                ],
              )
            : Row(
                children: [
                  AppButton(
                    onPressed: () => controller.onTapLeft(),
                    borderRadius: 11,
                    width: 12.93 * (w / 100),
                    hieght: 12.93 * (w / 100),
                    child: AppIcon(
                      path: AppIcons.arrowLeft,
                      matchTextDirection: true,
                    ),
                  ),
                  Spacer(),
                  Obx(() => IndicatorsBar(
                        pageIndex: controller.pageIndex,
                        length: controller.steps.length,
                      )),
                  Spacer(),
                  AppButton(
                    onPressed: () => controller.onTapRight(),
                    borderRadius: 11,
                    width: 12.93 * (w / 100),
                    hieght: 12.93 * (w / 100),
                    child: AppIcon(
                      path: AppIcons.arrowRight,
                      matchTextDirection: true,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

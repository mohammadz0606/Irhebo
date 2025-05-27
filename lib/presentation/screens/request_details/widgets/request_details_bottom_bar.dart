import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/screens/request_details/request_details_controller.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';

class RequestDetailsBottomBar extends GetWidget<RequestDetailsController> {
  const RequestDetailsBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (controller.request.isReviewed == false) ...[
            AppButton(
              onPressed: controller.request.isReviewed == true
                  ? () {}
                  : controller.openReviewBottomSheet,
              backGroundColor: Get.find<AppController>().darkMode
                  ? AppDarkColors.darkContainer
                  : Colors.white,
              borderColor: Get.find<AppController>().darkMode
                  ? AppDarkColors.greenContainer
                  : AppLightColors.primaryColor,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    controller.request.isReviewed == true
                        ? "Reviewed before".tr
                        : "Rate now".tr,
                    style: Get.theme.textTheme.labelMedium?.copyWith(
                        color: Get.find<AppController>().darkMode
                            ? null
                            : AppLightColors.primaryColor),
                  ),
                  SizedBox(
                    width: 1 * (w / 100),
                  ),
                  AppIcon(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    path: AppIcons.star,
                    width: 4.47 * (w / 100),
                    height: 4.47 * (w / 100),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 2 * (w / 100),
            ),
          ],
          AppButton(
            onPressed: controller.openUpdateRequestDialog,
            title: "Update Request",
          ),
          SizedBox(
            height: 2 * (w / 100),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.9 * (w / 100)),
            child: AppButton(
              onPressed: () => {},
              title: "Download Contract",
            ),
          ),
          SizedBox(
            height: 4 * (w / 100),
          ),
        ],
      ),
    );
  }
}

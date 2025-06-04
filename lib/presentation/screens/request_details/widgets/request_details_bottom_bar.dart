import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/screens/request_details/request_details_controller.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';
import '../../../../app/app_functions.dart';
import '../../../../app/enums.dart';

class RequestDetailsBottomBar extends GetWidget<RequestDetailsController> {
  const RequestDetailsBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (getUserRole != UserRoles.freelancer)
          Obx(() {
            final request = controller.request;
            if (request.statusKey == 'completed' &&
                request.isReviewed == false) {
              return Column(
                children: [
                  AppButton(
                    onPressed: controller.openReviewBottomSheet,
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
                          "Rate now".tr,
                          style: Get.theme.textTheme.labelMedium?.copyWith(
                            color: Get.find<AppController>().darkMode
                                ? null
                                : AppLightColors.primaryColor,
                          ),
                        ),
                        SizedBox(width: 1 * (w / 100)),
                        AppIcon(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          path: AppIcons.star,
                          width: 4.47 * (w / 100),
                          height: 4.47 * (w / 100),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2 * (w / 100)),
                ],
              );
            } else {
              return const SizedBox();
            }
          }),

        if (getUserRole == UserRoles.freelancer &&
            controller.request.statusKey == 'pending') ...{
          AppButton(
            onPressed: () {},
            title: "Confirm Request",
          ),
          SizedBox(height: 2 * (w / 100)),
        },

        // Remaining action buttons
        AppButton(
          onPressed: controller.openUpdateRequestDialog,
          title: "Update Request",
        ),
        SizedBox(height: 2 * (w / 100)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.9 * (w / 100)),
          child: AppButton(
            onPressed: () {},
            title: "Download Contract",
          ),
        ),
        SizedBox(height: 4 * (w / 100)),
      ],
    );
  }
}

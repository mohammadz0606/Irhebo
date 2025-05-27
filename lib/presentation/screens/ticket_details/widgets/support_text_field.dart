import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/screens/chat/widgets/field_place_holder.dart';
import 'package:irhebo/presentation/screens/ticket_details/ticket_details_controller.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';
import 'package:irhebo/presentation/widgets/app_text_field.dart';
import 'package:irhebo/presentation/widgets/decorated_icon.dart';

class SupportTextField extends GetWidget<TicketDetailsController> {
  const SupportTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Obx(
      () => Container(
        color: Get.find<AppController>().darkMode
            ? AppDarkColors.darkScaffoldColor
            : AppLightColors.scaffoldColor2,
        height: 21.2 * (w / 100),
        width: 100 * (w / 100),
        padding: EdgeInsets.only(
            bottom: 5 * (w / 100),
            left: 3 * (w / 100),
            right: 3 * (w / 100),
            top: 3 * (w / 100)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: AppTextField(
                fillColor:
                    Get.find<AppController>().darkMode ? null : Colors.white,
                onTap: () => controller.scrollToEnd(),
                hint: "Type Here".tr,
                isChat: true,
                onChange: (p0) => controller.onStartTyping(),
                controller: controller.chatMessage.value,
                suffixIcon: (controller.selectedFilePath.isNotEmpty)
                    ? GestureDetector(
                        onTap: () => controller.dismissFiles(),
                        child: SizedBox(
                          width: 17 * (w / 100),
                          child: FieldPlaceHolder(
                            forTicket: true,
                            isVoice: false,
                            selectedFilePath: controller.selectedFilePath,
                          ),
                        ),
                      )
                    : null,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3 * (w / 100)),
                  child: InkWell(
                    onTap: () => controller.selectedFilePath.isNotEmpty
                        ? controller.dismissFiles()
                        : controller.toggleAttachAnimation(),
                    child: AppIcon(
                      padding: EdgeInsets.zero,
                      path: controller.selectedFilePath.isNotEmpty
                          ? AppIcons.close
                          : AppIcons.add,
                      color: Get.find<AppController>().darkMode
                          ? AppDarkColors.greenContainer
                          : AppLightColors.primaryColor,
                      width: 6.46 * (w / 100),
                      height: 6.46 * (w / 100),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 1.74 * (w / 100),
            ),
            // if (controller.type != ChatType.Bot)
            InkWell(
              onTap: () =>
                  controller.isLoadingAdd ? null : controller.onTapSend(),
              child: controller.isLoadingAdd
                  ? Container(
                      width: 12.43 * (w / 100),
                      height: 12.43 * (w / 100),
                      padding: EdgeInsets.all(2.98 * (w / 100)),
                      decoration: BoxDecoration(
                        // color: color ?? AppColors.lightPrimary,
                        color: Get.find<AppController>().darkMode
                            ? AppDarkColors.darkContainer2
                            : Colors.white,
                        borderRadius: BorderRadius.circular(50 * (w / 100)),
                      ),
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    )
                  : DecoratedIcon(
                      padding: 2.98 * (w / 100),
                      width: 12.93 * (w / 100),
                      height: 12.93 * (w / 100),
                      matchTextDirection: true,
                      color: Get.find<AppController>().darkMode
                          ? AppDarkColors.darkContainer2
                          : Colors.white,
                      imagePath: AppIcons.send,
                      svgColor: Get.find<AppController>().darkMode
                          ? AppDarkColors.greenContainer
                          : AppLightColors.primaryColor,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

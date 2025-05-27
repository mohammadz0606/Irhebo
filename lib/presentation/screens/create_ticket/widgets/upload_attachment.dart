import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';

class UploadAttachment extends StatelessWidget {
  final Function() onOpenFile;

  const UploadAttachment({
    super.key,
    required this.onOpenFile,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upload Attachment".tr,
          style: Get.theme.textTheme.labelMedium!
              .copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 2 * (w / 100),
        ),
        AppButton(
          borderRadius: 12,
          borderColor: Get.find<AppController>().darkMode
              ? AppDarkColors.greenContainer
              : AppLightColors.greenContainer,
          backGroundColor: Get.find<AppController>().darkMode
              ? AppDarkColors.darkContainer2
              : AppLightColors.fillTextField,
          hieght: 13.9 * (w / 100),
          width: 33.5 * (w / 100),
          onPressed: () => onOpenFile(),
          child: AppIcon(
            path: AppIcons.upload,
            width: 5.97 * (w / 100),
            height: 5.97 * (w / 100),
          ),
        ),
      ],
    );
  }
}

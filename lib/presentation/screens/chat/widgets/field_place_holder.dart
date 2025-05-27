import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/text_style.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';
import 'package:mime/mime.dart';

class FieldPlaceHolder extends StatelessWidget {
  final List<String?> selectedFilePath;
  final bool isVoice;
  final bool forTicket;
  const FieldPlaceHolder({
    super.key,
    required this.selectedFilePath,
    required this.isVoice,
    this.forTicket = false,
  });
  // List<String> groupedKeys = controller.groupedMessages.keys.toList();

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      height: 10 * (w / 100),
      padding: EdgeInsets.symmetric(horizontal: 3 * (w / 100)),
      decoration: BoxDecoration(
          border: Border.all(color: AppDarkColors.primaryColor, width: 2),
          color: Get.find<AppController>().darkMode
              ? AppDarkColors.darkContainer
              : AppLightColors.secondary,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            child: Center(
              child: AppIcon(
                path: forTicket
                    ? AppIcons.attachment
                    : selectedFilePath.length > 1
                        ? AppIcons.docMsg
                        : getMessageIcon(selectedFilePath[0] ?? ""),
                width: 5 * (w / 100),
                height: 5 * (w / 100),
                color: Get.find<AppController>().darkMode
                    ? AppDarkColors.pureWhite.withOpacity(0.5)
                    : AppLightColors.primaryColor,
              ),
            ),
          ),
          SizedBox(width: forTicket ? 1 * (w / 100) : 2 * (w / 100)),
          Expanded(
            child: Text(
              forTicket
                  ? selectedFilePath.length.toString()
                  : isVoice
                      ? "voice".tr
                      : selectedFilePath.length > 1
                          ? "${selectedFilePath.length} ${"files".tr}"
                          : (selectedFilePath.first?.contains("\\") == true)
                              ? selectedFilePath.first?.split("\\").last ?? ""
                              : selectedFilePath.first?.split("/").last ?? "",
              style: Get.theme.textTheme.labelSmall!.copyWith(
                  color: Get.find<AppController>().darkMode
                      ? AppDarkColors.pureWhite.withOpacity(0.5)
                      : AppLightColors.primaryColor,
                  fontSize: forTicket ? AppTextStyle.size14 : null),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  String getMessageIcon(String path) {
    String type = lookupMimeType(path) ?? "";
    if (type.startsWith("image")) {
      return AppIcons.imgMsg;
    }
    if (type.startsWith("video")) {
      return AppIcons.vidMsg;
    }
    if (type.startsWith("audio")) {
      return AppIcons.audMsg;
    }
    return AppIcons.docMsg;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/screens/chat/chat_controller.dart';
import 'package:irhebo/presentation/screens/chat/widgets/field_place_holder.dart';
import 'package:irhebo/presentation/screens/chat/widgets/mic_animation.dart';
import 'package:irhebo/presentation/screens/chat/widgets/mic_timer.dart';
import 'package:irhebo/presentation/screens/chat/widgets/wave_widget.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';

class ChatFieldPrefix extends GetWidget<ChatController> {
  const ChatFieldPrefix({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Obx(
      () => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3 * (w / 100)),
            child: InkWell(
              onTap: () => controller.onTapPrefix(),
              child: AppIcon(
                padding: EdgeInsets.zero,
                path: controller.selectedFilePath.isNotEmpty ||
                        controller.isRecord.value
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
          if (controller.selectedFilePath.isNotEmpty &&
              !controller.isRecord.value) ...[
            Expanded(
              child: FieldPlaceHolder(
                isVoice: controller.isRecord.value,
                selectedFilePath: controller.selectedFilePath,
              ),
            ),
            SizedBox(
              width: 3 * (w / 100),
            )
          ],
          if (controller.isRecord.value) ...[
            Stack(
              fit: StackFit.loose,
              children: [
                MicTimer(),
                const MicAnimation(),
              ],
            ),
            SizedBox(
              width: 3 * (w / 100),
            ),
            Expanded(
              child: WaveWidget(
                recorder: controller.recorderController,
              ),
            ),
            SizedBox(
              width: 3 * (w / 100),
            )
          ],
        ],
      ),
    );
  }
}

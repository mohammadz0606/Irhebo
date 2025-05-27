import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/screens/chat/animation_button_controller.dart';

class MicTimer extends GetView<AnimationButtonController> {
  const MicTimer({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Obx(
      () => controller.chatController.isRecord.value
          ? Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1 * (w / 100)),
                  child: AnimatedBuilder(
                    animation: controller.chatController.timerAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: controller.chatController.timerAnimation.value,
                        child: Icon(
                          Icons.mic,
                          color: AppDarkColors.red,
                          size: 6 * (w / 100),
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  "${controller.towDigits(controller.chatController.duration.inMinutes)}:${controller.towDigits(controller.chatController.duration.inSeconds.remainder(60))}",
                  style: context.textTheme.labelSmall,
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}

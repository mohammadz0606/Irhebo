import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/screens/chat/animation_button_controller.dart';

class MicAnimation extends GetView<AnimationButtonController> {
  const MicAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: 4 * (w / 100),
            ),
            child: Obx(
              () => !controller.isMicAnimating
                  ? const SizedBox()
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AnimatedBuilder(
                          animation: controller.micController,
                          builder: (context, child) {
                            return Transform(
                              transform: Matrix4.identity()
                                ..translate(0.0, 8.8)
                                ..translate(controller.micTranslateRight.value)
                                ..translate(controller.micTranslateLeft.value)
                                ..translate(
                                    0.0, controller.micTranslateTop.value)
                                ..translate(
                                    0.0, controller.micTranslateDown.value)
                                ..translate(
                                    0.0,
                                    controller
                                        .micInsideTrashTranslateDown.value),
                              child: Transform.rotate(
                                angle: controller.micRotationFirst.value,
                                child: Transform.rotate(
                                  angle: controller.micRotationSecond.value,
                                  child: child,
                                ),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.mic,
                            color: AppDarkColors.red,
                            size: 5 * (w / 100),
                          ),
                        ),
                        AnimatedBuilder(
                            animation: controller.trashWithCoverTranslateTop,
                            builder: (context, child) {
                              return Transform(
                                transform: Matrix4.identity()
                                  ..translate(
                                      0.0,
                                      controller
                                          .trashWithCoverTranslateTop.value)
                                  ..translate(
                                      0.0,
                                      controller
                                          .trashWithCoverTranslateDown.value),
                                child: child,
                              );
                            },
                            child: Column(
                              children: [
                                AnimatedBuilder(
                                  animation: controller.trashCoverRotationFirst,
                                  builder: (context, child) {
                                    return Transform(
                                      transform: Matrix4.identity()
                                        ..translate(controller
                                            .trashCoverTranslateLeft.value)
                                        ..translate(controller
                                            .trashCoverTranslateRight.value),
                                      child: Transform.rotate(
                                        angle: controller
                                            .trashCoverRotationSecond.value,
                                        child: Transform.rotate(
                                          angle: controller
                                              .trashCoverRotationFirst.value,
                                          child: child,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Image(
                                    image: AssetImage(AppImages.trashCover),
                                    width: 6 * (w / 100),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 0.5 * (w / 100)),
                                  child: Image(
                                    image: AssetImage(AppImages.trashContainer),
                                    width: 6 * (w / 100),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

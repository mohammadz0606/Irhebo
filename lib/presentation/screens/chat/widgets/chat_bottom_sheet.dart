import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/presentation/screens/chat/chat_controller.dart';
import 'package:irhebo/presentation/screens/chat/widgets/chat_text_field.dart';
import 'package:irhebo/presentation/screens/chat/widgets/pick_item_widget.dart';

class ChatBottomSheet extends GetWidget<ChatController> {
  const ChatBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Animate(
          autoPlay: false,
          onInit: (controller2) {
            controller.galleryAnimationController = controller2;
          },
          effects: [
            FadeEffect(
                begin: 0,
                end: 1,
                duration: 200.ms,
                curve: Curves.fastLinearToSlowEaseIn),
            SlideEffect(
                begin: Offset(0, 3),
                end: Offset(0, 0),
                duration: 200.ms,
                curve: Curves.fastLinearToSlowEaseIn),
          ],
          child: PickItemWidget(
            icon: AppIcons.imgMsg,
            title: "Gallery",
            onTap: () => controller.pickChatFile(FileType.media),
          ),
        ),
        Animate(
          autoPlay: false,
          onInit: (controller2) {
            controller.audioAnimationController = controller2;
          },
          effects: [
            FadeEffect(
                begin: 0,
                end: 1,
                duration: 200.ms,
                curve: Curves.fastLinearToSlowEaseIn),
            SlideEffect(
                begin: Offset(0, 3),
                end: Offset(0, 0),
                duration: 200.ms,
                curve: Curves.fastLinearToSlowEaseIn),
          ],
          child: PickItemWidget(
            icon: AppIcons.audMsg,
            title: "Audio",
            onTap: () => controller.pickChatFile(FileType.any),
          ),
        ),
        Animate(
          autoPlay: false,
          onInit: (controller2) {
            controller.documentAnimationController = controller2;
          },
          effects: [
            FadeEffect(
                begin: 0,
                end: 1,
                duration: 200.ms,
                curve: Curves.fastLinearToSlowEaseIn),
            SlideEffect(
                begin: Offset(0, 3),
                end: Offset(0, 0),
                duration: 200.ms,
                curve: Curves.fastLinearToSlowEaseIn),
          ],
          child: PickItemWidget(
            icon: AppIcons.docMsg,
            title: "File",
            onTap: () => controller.pickChatFile(FileType.any),
          ),
        ),
        ChatTextField(),
      ],
    );
  }
}

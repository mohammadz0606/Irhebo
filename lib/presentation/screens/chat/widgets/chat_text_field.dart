import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/domain/providers/chat/chat_provider.dart';
import 'package:irhebo/presentation/screens/chat/chat_controller.dart';
import 'package:irhebo/presentation/screens/chat/widgets/chat_field_prefix.dart';
import 'package:irhebo/presentation/widgets/app_text_field.dart';
import 'package:irhebo/presentation/widgets/decorated_icon.dart';

import '../../../../app/global_imports.dart';
import '../../../../domain/params/new_params/chat/send_message_param.dart';

class ChatTextField extends GetWidget<ChatController> {
  const ChatTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      color: Get.find<AppController>().darkMode
          ? AppDarkColors.darkScaffoldColor
          : AppLightColors.scaffoldColor2,
      height: 21.2 * (w / 100),
      width: 100 * (w / 100),
      padding: EdgeInsets.only(
          bottom: 5 * (w / 100),
          left:
              controller.type == ChatType.Bot ? 3.9 * (w / 100) : 3 * (w / 100),
          right:
              controller.type == ChatType.Bot ? 3.9 * (w / 100) : 3 * (w / 100),
          top: 3 * (w / 100)),
      child: Consumer<ChatProvider>(
        builder: (context, provider, _) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: AppTextField(
                  fillColor:
                      Get.find<AppController>().darkMode ? null : Colors.white,
                  onTap: () => controller.type == ChatType.Bot
                      ? null
                      : controller.onTapField(),
                  hint: controller.type == ChatType.Bot
                      ? "Type Here".tr
                      : controller.selectedFilePath.isNotEmpty ||
                              controller.attachAnimated.value
                          ? ""
                          : "Type Here".tr,
                  isChat: true,
                  onChange: (p0) => controller.onStartTyping(),
                  controller: controller.chatMessage.value,
                  prefixIcon: controller.type == ChatType.Bot
                      ? null
                      : const ChatFieldPrefix(),
                ),
              ),
              SizedBox(
                width: 1.74 * (w / 100),
              ),
              InkWell(
                onTap: () async {
                  controller.onTapSend();
                  await provider.sendMessage(
                      sendParam: SendMessageParam(
                    message: controller.chatMessage.value.text,
                    chatId: controller.chatId,
                    messageType: MessageType.text,
                    attachmentFile: null,
                  ));
                  controller.chatMessage.value.clear();
                },
                child: Obx(
                  () {
                    return DecoratedIcon(
                      padding: 2.98 * (w / 100),
                      width: 12.93 * (w / 100),
                      height: 12.93 * (w / 100),
                      matchTextDirection: true,
                      color: Get.find<AppController>().darkMode
                          ? AppDarkColors.darkContainer2
                          : Colors.white,
                      //imagePath: AppIcons.send,
                      imagePath: controller.type == ChatType.Bot ||
                              controller.selectedFilePath.isNotEmpty ||
                              controller.chatMessage.value.text
                                  .trim()
                                  .isNotEmpty ||
                              controller.isRecord.value
                          ? AppIcons.send
                          : AppIcons.mic,
                      svgColor: AppDarkColors.greenContainer,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

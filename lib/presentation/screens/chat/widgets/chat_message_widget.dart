import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/app_functions.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/domain/entities/message_entity.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';
import 'package:irhebo/presentation/widgets/decorated_icon.dart';

class ChatMessageWidget extends StatelessWidget {
  final bool sender;
  final ChatType type;
  final ChatMessageEntity message;
  const ChatMessageWidget(
      {super.key,
      required this.sender,
      required this.message,
      required this.type});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      child: Align(
        alignment: message.sender
            ? AlignmentDirectional.centerEnd
            : AlignmentDirectional.centerStart,
        child: Padding(
          padding: EdgeInsetsDirectional.only(
              bottom: 3.48 * (w / 100),
              start: 5.97 * (w / 100),
              end: 5.97 * (w / 100)),
          child: Column(
            crossAxisAlignment: message.sender
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: 74.62 * (w / 100),
                        minWidth: 14.92 * (w / 100)),
                    // width: 74.62*(w/100),
                    padding: EdgeInsets.only(
                        right: 5 * (w / 100),
                        left: 5 * (w / 100),
                        top: 3 * (w / 100),
                        bottom: 3 * (w / 100)),
                    decoration: BoxDecoration(
                      color: message.sender
                          ? AppDarkColors.primaryColor
                          : Get.find<AppController>().darkMode
                              ? AppDarkColors.darkContainer2
                              : Colors.white,
                      borderRadius:
                          message.sender ? senderRadius : receiverRadius,
                    ),
                    child: Text(
                      message.message,
                      style: Get.theme.textTheme.bodySmall!.copyWith(
                          color: message.sender
                              ? Colors.white
                              : Get.find<AppController>().darkMode
                                  ? Colors.white
                                  : Colors.black),
                    ),
                  ),
                  if (!message.sender)
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.createTicket),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 1 * (w / 100)),
                        decoration: Get.find<AppController>().darkMode
                            ? AppDecoration.getGradientWithRadius(
                                dark: Get.find<AppController>().darkMode,
                                radius: 50 * (w / 100))
                            : null,
                        child: DecoratedIcon(
                          height: 8 * (w / 100),
                          width: 8 * (w / 100),
                          padding: 2 * (w / 100),
                          color: Get.find<AppController>().darkMode
                              ? AppDarkColors.darkScaffoldColor
                              : AppLightColors.secondary,
                          imagePath: AppIcons.report,
                          // svgColor: AppColors.pureWhite,
                        ),
                      ),
                    ),
                ],
              ),
              if (type != ChatType.Bot)
                Padding(
                  padding: EdgeInsets.only(top: 1.74 * (w / 100)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        formatTime(message.timestamp),
                        style: Get.theme.textTheme.labelMedium!
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 0.74 * (w / 100),
                      ),
                      AppIcon(
                        path: AppIcons.done,
                        height: 5.79 * (w / 100),
                        width: 5.79 * (w / 100),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

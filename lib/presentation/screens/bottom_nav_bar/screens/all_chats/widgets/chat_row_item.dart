import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/extensions.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/app/resources/style/text_style.dart';
import 'package:irhebo/domain/entities/chat_entity.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';

import '../../../../../../domain/models/new_models/chat/chat_list_model.dart';

class ChatRowItem extends StatelessWidget {
  final ChatListModelData chat;
  final Function() onDeleted;
  final Function() onTapMore;
  final Function(int) onChangeValue;

  const ChatRowItem({
    super.key,
    required this.chat,
    required this.onDeleted,
    required this.onTapMore,
    required this.onChangeValue,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.97 * (w / 100)),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Get.find<AppController>().darkMode
                ? Colors.white.withOpacity(0.5)
                : AppLightColors.dividerColor,
          ),
        ),
      ),
      child: Container(
        // color: Colors.green,
        padding: EdgeInsets.symmetric(vertical: 4.97 * (w / 100)),

        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppImage(
              imageUrl: chat.receiver?.image ?? AppImages.placeholder,
              width: 10.69 * (w / 100),
              height: 10.69 * (w / 100),
              radius: 50 * (w / 100),
            ),
            SizedBox(
              width: 2.98 * (w / 100),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              chat.receiver?.username ?? "",
                              style: Get.theme.textTheme.labelMedium!
                                  .copyWith(fontWeight: FontWeight.w600),
                              // maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              width: 2 * (w / 100),
                            ),
                            Visibility(
                              visible: chat.unreadCount != 0,
                              child: Container(
                                //width: 6 * (w / 100),
                                margin: EdgeInsets.symmetric(
                                  horizontal: 1 * (w / 100),
                                ),
                                decoration:
                                    AppDecoration.getDecorationWithRadius(
                                  radius: 50 * (w / 100),
                                  color: AppDarkColors.redBadge,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 1.24 * (w / 100),
                                    vertical: 0.49 * (w / 100),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${chat.unreadCount ?? 0}',
                                      style: Get.theme.textTheme.labelSmall!
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Get.find<AppController>().darkMode
                                                ? null
                                                : Colors.white,
                                        fontSize: AppTextStyle.size11,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 2 * (w / 100),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 1 * (w / 100)),
                        child: Text(
                          chat.lastMessage?.createdAt?.formatTimeAgo ?? '',
                          style: Get.theme.textTheme.labelSmall!.copyWith(
                              color: AppDarkColors.pureWhite.withOpacity(0.5)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.24 * (w / 100),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat.lastMessage?.message ?? '',
                          style: Get.theme.textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 2 * (w / 100),
                      ),
                      Expanded(child: Container()),
                      SizedBox(
                        child: PopupMenuButton<int>(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          menuPadding: EdgeInsets.zero,
                          onSelected: (value) => onChangeValue(value),
                          elevation: Get.find<AppController>().darkMode ? 2 : 8,
                          child: Padding(
                            padding: EdgeInsets.all(1 * (w / 100)),
                            child: AppIcon(
                              path: AppIcons.moreIcon,
                              color: Get.find<AppController>().darkMode
                                  ? AppDarkColors.pureWhite
                                  : Colors.black,
                              height: 5 * (w / 100),
                            ),
                          ),
                          itemBuilder: (BuildContext context) => [
                            buildPopUpButton(
                                title: "Delete",
                                value: 1,
                                w: w,
                                icon: Icons.delete),
                            buildPopUpButton(
                                title: "Move to Spam",
                                value: 2,
                                w: w,
                                icon: Icons.report),
                            buildPopUpButton(
                              title: "Move to Starred",
                              value: 3,
                              w: w,
                              icon: Icons.star,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  buildPopUpButton({
    required String title,
    required int value,
    required IconData icon,
    required double w,
  }) {
    return PopupMenuItem(
        value: value,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                color: Get.find<AppController>().darkMode
                    ? Colors.white.withOpacity(0.7)
                    : AppLightColors.primaryColor.withOpacity(0.7)),
            SizedBox(
              width: 2 * (w / 100),
            ),
            Text(
              title.tr,
              style: Get.theme.textTheme.labelMedium!.copyWith(
                  color: Get.find<AppController>().darkMode
                      ? Colors.white.withOpacity(0.7)
                      : Colors.black.withOpacity(0.5)),
            )
          ],
        ));
  }
}

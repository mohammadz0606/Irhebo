import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/app_functions.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/domain/providers/chat/chat_provider.dart';

import 'package:irhebo/presentation/widgets/app_icon.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';
import 'package:irhebo/presentation/widgets/open_file_items.dart';

import '../../../../app/global_imports.dart';
import '../../../../domain/models/new_models/chat/chat_messages_model.dart';
import '../../../widgets/app_image.dart';
import '../../../widgets/audio_player.dart';
import '../../../widgets/video_player.dart';
import '../gallery_chats_screen.dart';

class ChatMessageWidget extends StatelessWidget {
  //final bool sender;
  final ChatType type;
  final int userId;
  final ChatMessagesModelDataMessages message;
  final int currentIndex;

  const ChatMessageWidget({
    super.key,
    // required this.sender,
    required this.message,
    required this.type,
    required this.userId,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Align(
      alignment: message.sender?.id == userId
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          bottom: 3.48 * (w / 100),
          start: 5.97 * (w / 100),
          end: 5.97 * (w / 100),
        ),
        child: Consumer<ChatProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: message.sender?.id == userId
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Opacity(
                  opacity: message.message == '/////vvvXXX////' ? 0 : 1,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 74.62 * (w / 100),
                          minWidth: 14.92 * (w / 100),
                        ),
                        // width: 74.62*(w/100),
                        padding: EdgeInsets.only(
                          right: 5 * (w / 100),
                          left: 5 * (w / 100),
                          top: 3 * (w / 100),
                          bottom: 3 * (w / 100),
                        ),
                        decoration: BoxDecoration(
                          color: message.sender?.id == userId
                              ? AppDarkColors.primaryColor
                              : Get.find<AppController>().darkMode
                              ? AppDarkColors.darkContainer2
                              : Colors.white,
                          borderRadius: message.sender?.id == userId
                              ? senderRadius
                              : receiverRadius,
                        ),
                        child: message.attachmentType == 'image'
                            ? GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return GalleryChatsScreen(
                                    currentPath:
                                    message.attachmentUrl ?? '',
                                    isVideo: false,
                                    images: provider.chatMessages
                                        ?.where(
                                          (e) =>
                                      e.attachmentType ==
                                          'image',
                                    )
                                        .toList() ??
                                        [],
                                  );
                                },
                              ),
                            );
                          },
                          child: AppImage(
                            imageUrl: message.attachmentUrl ??
                                AppImages.placeholder,
                            fit: BoxFit.fill,
                            radius: 10,
                            width: 70 * (w / 100),
                            height: 70 * (w / 100),
                          ),
                        )
                            : message.attachmentType == 'file'
                            ? OpenFileItems(pathUrl: message.attachmentUrl)
                            : message.attachmentType == 'video'
                            ? GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return GalleryChatsScreen(
                                    currentPath:
                                    message.attachmentUrl ?? '',
                                    isVideo: true,
                                    images: provider.chatMessages
                                        ?.where(
                                          (e) =>
                                      e.attachmentType ==
                                          'video',
                                    )
                                        .toList() ??
                                        [],
                                  );
                                },
                              ),
                            );
                          },
                          child: AppVideoPlayer(
                            videoUrl: message.attachmentUrl ?? '',
                            radius: 10,
                          ),
                        )
                            : message.attachmentType == 'audio'
                            ? AppAudioPlayer(
                          audioUrl: message.attachmentUrl ?? '',
                          radius: 10,
                        )
                            : message.attachmentType == 'call'
                            ? ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            radius: 20.r,
                            backgroundColor:
                            AppLightColors.dividerColor,
                            child: const Icon(
                              CupertinoIcons
                                  .phone_arrow_up_right,
                              color: AppLightColors
                                  .primaryColor,
                            ),
                          ),
                          title: Text('Call'.tr),
                          subtitle: Text(
                            message.message ?? '',
                          ),
                          titleTextStyle: Get
                              .theme.textTheme.headlineSmall
                              ?.copyWith(
                            fontSize: 19,
                          ),
                          subtitleTextStyle: Get
                              .theme.textTheme.bodySmall
                              ?.copyWith(
                            color: message.sender?.id ==
                                userId
                                ? Colors.white
                                : Get.find<AppController>()
                                .darkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                        )
                            : Text(
                          message.message ?? '',
                          style: Get
                              .theme.textTheme.bodySmall
                              ?.copyWith(
                            color: message.sender?.id ==
                                userId
                                ? Colors.white
                                : Get.find<AppController>()
                                .darkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (type != ChatType.Bot)
                  Visibility(
                    visible: message.message != '/////vvvXXX////',
                    child: Padding(
                      padding: EdgeInsets.only(top: 1.74 * (w / 100)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            formatTime(message.createdAt ?? DateTime.now()),
                            style: Get.theme.textTheme.labelMedium!
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          // SizedBox(
                          //   width: 0.74 * (w / 100),
                          // ),
                          // if (message.isRead == 1)
                          //   AppIcon(
                          //     path: AppIcons.done,
                          //     height: 5.79 * (w / 100),
                          //     width: 5.79 * (w / 100),
                          //   )
                          // else
                          //   const Icon(
                          //     CupertinoIcons.check_mark,
                          //     color: CupertinoColors.activeGreen,
                          //   )
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
// if (message.attachmentType == MessageType.file.name) {
//   return OpenFileItems(pathUrl: message.attachmentUrl);
// } else if (message.attachmentType == MessageType.image.name) {
//   return AppImage(
//     imageUrl: message.attachmentUrl ?? AppImages.placeholder,
//     fit: BoxFit.fill,
//     radius: 20,
//     width: 100,
//     height: 100,
//   );
// }

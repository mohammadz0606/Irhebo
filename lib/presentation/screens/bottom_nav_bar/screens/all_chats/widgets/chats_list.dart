import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/domain/entities/chat_entity.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/all_chats/all_chats_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/all_chats/widgets/chat_row_item.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/all_chats/widgets/chats_shimmer.dart';

import '../../../../../../app/global_imports.dart';
import '../../../../../../domain/providers/chat/chat_provider.dart';

class ChatsList extends GetWidget<AllChatsController> {
  const ChatsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return Consumer<ChatProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            for (int i = 0; i < provider.allChatListByFilter!.length; i++)
              Visibility(
                // visible: controller.selectedTab.name ==
                //     controller.chats[i].type ||
                //     controller.selectedTab.name == "All",
                child: GestureDetector(
                  onTap: () async {
                    Get.toNamed(
                      AppRoutes.chat,
                      arguments: {
                        "chat_type": ChatType.Users,
                        'userId': provider.allChatListByFilter![i].receiver?.id ?? 0,
                        'chatId': provider.allChatListByFilter![i].chatId ?? 0,
                      },
                    );

                    if (provider.allChatListByFilter![i].unreadCount != 0) {
                      await provider
                          .markRead(
                        chatId: provider.allChatListByFilter![i].chatId ?? 0,
                      )
                          .then(
                        (value) async {
                          await provider.getChatList();
                        },
                      );
                    }
                  },
                  child: ChatRowItem(
                    onChangeValue: (val) => controller.onChangeStatus(val, i),
                    onDeleted: () => controller.onDeleteChat(i),
                    onTapMore: () => controller.onTapMoreOnChat(i),
                    chat: provider.allChatListByFilter![i],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

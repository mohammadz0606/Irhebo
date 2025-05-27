import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/all_chats/all_chats_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/all_chats/widgets/chat_row_item.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/all_chats/widgets/chats_shimmer.dart';

class ChatsList extends GetWidget<AllChatsController> {
  const ChatsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return Obx(
      () => controller.isLoading
          ? Column(
              children: [for (int i = 0; i < 8; i++) ChatsShimmer()],
            )
          : Column(
              children: [
                for (int i = 0; i < controller.chats.length; i++)
                  Visibility(
                    visible: controller.selectedTab.name ==
                            controller.chats[i].type ||
                        controller.selectedTab.name == "All",
                    child: GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.chat,
                          arguments: {"chat_type": ChatType.Users}),
                      child: ChatRowItem(
                        onChangeValue: (val) =>
                            controller.onChangeStatus(val, i),
                        onDeleted: () => controller.onDeleteChat(i),
                        onTapMore: () => controller.onTapMoreOnChat(i),
                        chat: controller.chats[i],
                      ),
                    ),
                  )
              ],
            ),
    );
  }
}

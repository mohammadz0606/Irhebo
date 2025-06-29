import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/domain/providers/chat/chat_provider.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/all_chats/all_chats_controller.dart';
import 'package:irhebo/presentation/screens/search/widgets/tag_item.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

import '../../../../../../app/global_imports.dart';

class ChatsFiltersList extends GetWidget<AllChatsController> {
  const ChatsFiltersList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, provider, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < ChatStatus.values.length; i++)
              TagItem(
                //freelancer: true,
                selected: provider.chatStatus == ChatStatus.values[i],
                title: ChatStatus.values[i].name.chatStatusTitle,
                onTapTag: () {
                  //controller.onChangeTab(ChatsTabs.values[i]);
                  provider.filterChat(ChatStatus.values[i]);
                },
              ),
          ],
        );
      },
    );

    // return Obx(
    //   () => controller.isLoading
    //       ? Row(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             for (int i = 0; i < 4; i++)
    //               Padding(
    //                 padding: EdgeInsets.symmetric(horizontal: 1.49 * (w / 100)),
    //                 child: AppLoading(
    //                   width: 18.15 * (w / 100),
    //                   height: 9.2 * (w / 100),
    //                   radius: 50 * (w / 100),
    //                 ),
    //               )
    //           ],
    //         )
    //       : Row(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             for (int i = 0; i < ChatsTabs.values.length; i++)
    //               Obx(
    //                 () => TagItem(
    //                   // freelancer: true,
    //                   selected: ChatsTabs.values[i] == controller.selectedTab,
    //                   title: ChatsTabs.values[i].name,
    //                   onTapTag: () =>
    //                       controller.onChangeTab(ChatsTabs.values[i]),
    //                 ),
    //               ),
    //           ],
    //         ),
    // );
  }
}

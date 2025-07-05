import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/domain/providers/chat/chat_provider.dart';
import 'package:irhebo/presentation/screens/chat/chat_controller.dart';
import 'package:irhebo/presentation/screens/chat/widgets/chat_app_bar.dart';
import 'package:irhebo/presentation/screens/chat/widgets/chat_bottom_sheet.dart';
import 'package:irhebo/presentation/screens/chat/widgets/chat_messages_list.dart';

import '../../../app/global_imports.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Consumer<ChatProvider>(
      builder: (context, provider, _) {
        return WillPopScope(
          onWillPop: controller.onWillPop,
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                controller.showSearch.value ? 32 * (w / 100) : 15 * (w / 100),
              ),
              child: Visibility(
                visible: !provider.isLoadingGetChatMessages,
                replacement: const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                child: ChatAppBar(
                  title: provider.appbarData?.username ?? '',
                  imageUrl: provider.appbarData?.avatar,
                  showSearch: controller.showSearch.value,
                  onTapSearch: () => controller.showSearchField(),
                  type: controller.type,
                  receiverId: controller.userId,
                  onTapBack: () async {
                   await controller.onWillPop();
                  },
                ),
              ),
            ),
            body: Visibility(
              visible: !provider.isLoadingGetChatMessages,
              replacement: const Align(
                alignment: Alignment.topCenter,
                child: LinearProgressIndicator(),
              ),
              child: const ChatMessagesList(),
            ),
            bottomSheet: const ChatBottomSheet(),
          ),
        );
      },
    );
  }
}

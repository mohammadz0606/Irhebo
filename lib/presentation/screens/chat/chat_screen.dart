import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/chat/chat_controller.dart';
import 'package:irhebo/presentation/screens/chat/widgets/chat_app_bar.dart';
import 'package:irhebo/presentation/screens/chat/widgets/chat_bottom_sheet.dart';
import 'package:irhebo/presentation/screens/chat/widgets/chat_messages_list.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Obx(
      () => WillPopScope(
        onWillPop: () => controller.onWillPop(),
        child: GestureDetector(
          onTap: () => controller.onTapOutside(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(controller.showSearch.value
                    ? 32 * (w / 100)
                    : 15 * (w / 100)),
                child: ChatAppBar(
                  title: "Abdallah Al Kateb",
                  showSearch: controller.showSearch.value,
                  onTapSearch: () => controller.showSearchField(),
                  type: controller.type,
                )),
            body: controller.groupedMessages.isEmpty
                ? Container()
                : const ChatMessagesList(),
            bottomSheet: const ChatBottomSheet(),
          ),
        ),
      ),
    );
  }
}

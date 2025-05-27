import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/chat/chat_controller.dart';
import 'package:irhebo/presentation/screens/chat/widgets/chat_message_widget.dart';
import 'package:irhebo/presentation/screens/chat/widgets/date_widget.dart';

class ChatMessagesList extends GetWidget<ChatController> {
  const ChatMessagesList({
    super.key,
  });
  // List<String> groupedKeys = controller.groupedMessages.keys.toList();

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(bottom: 21 * (w / 100)),
        child: ListView.builder(
          shrinkWrap: true,
          reverse: true, // Newest messages at the bottom
          controller: controller.chatScrollController,
          itemCount: (controller.groupedMessages.keys.toList()).length,
          itemBuilder: (context, index) {
            // String date = groupedKeys[index];
            // List<ChatMessage> messages =
            //     controller.groupedMessages[groupedKeys[index]]!;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date Header
                DateWidget(
                  date: (controller.groupedMessages.keys.toList())[index],
                ),
                // Messages for this date
                ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller
                      .groupedMessages[
                          (controller.groupedMessages.keys.toList())[index]]!
                      .length,
                  itemBuilder: (context, msgIndex) {
                    // ChatMessage message = messages[msgIndex];
                    // bool isCurrentUser = message.senderId == currentUserId;
                    return ChatMessageWidget(
                      message: controller.groupedMessages[(controller
                          .groupedMessages.keys
                          .toList())[index]]![msgIndex],
                      sender: true,
                      type: controller.type,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

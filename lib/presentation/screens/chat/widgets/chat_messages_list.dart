import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/domain/providers/chat/chat_provider.dart';
import 'package:irhebo/presentation/screens/chat/chat_controller.dart';
import 'package:irhebo/presentation/screens/chat/widgets/chat_message_widget.dart';
import 'package:irhebo/presentation/screens/chat/widgets/date_widget.dart';

import '../../../../app/enums.dart';
import '../../../../app/global_imports.dart';

class ChatMessagesList extends StatefulWidget {
  const ChatMessagesList({
    super.key,
  });

  @override
  State<ChatMessagesList> createState() => _ChatMessagesListState();
}

class _ChatMessagesListState extends State<ChatMessagesList> {
  final ScrollController chatScrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //scrollToEnd();
    });
    super.initState();
  }

  @override
  void dispose() {
    chatScrollController.dispose();
    super.dispose();
  }

  scrollToEnd() async {
    await Future.delayed(
      const Duration(milliseconds: 500),
      () {
        chatScrollController.animateTo(
          chatScrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        );
      },
    );
  }

  // List<String> groupedKeys = controller.groupedMessages.keys.toList();
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Consumer<ChatProvider>(
      builder: (context, provider, _) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (chatScrollController.hasClients) {
            chatScrollController.animateTo(
              chatScrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
            );
          }
        });
        return ListView.builder(
          padding: EdgeInsets.only(bottom: 21 * (w / 100)),
          shrinkWrap: true,
          reverse: true,
          // Newest messages at the bottom
          controller: chatScrollController,
          itemCount: (provider.groupedMessages?.keys.toList())?.length ?? 0,
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
                  date: (provider.groupedMessages?.keys.toList() ?? [])[index],
                ),
                // Messages for this date
                ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider
                      .groupedMessages?[
                          (provider.groupedMessages?.keys.toList() ??
                              [])[index]]!
                      .length,
                  itemBuilder: (context, msgIndex) {
                    // ChatMessage message = messages[msgIndex];
                    // bool isCurrentUser = message.senderId == currentUserId;

                    AppPreferences prefs = sl();

                    int userId = prefs.getInt(key: AppPrefsKeys.USER_ID) ?? 0;

                    return ChatMessageWidget(
                      message: provider.groupedMessages![
                          (provider.groupedMessages?.keys.toList() ??
                              [])[index]]![msgIndex],
                      type: ChatType.Users,
                      userId: userId,
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

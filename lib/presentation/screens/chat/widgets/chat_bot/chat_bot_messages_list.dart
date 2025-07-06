import 'package:irhebo/domain/providers/chat/chat_bot_provider.dart';

import '../../../../../app/global_imports.dart';
import '../date_widget.dart';
import 'chat_bot_message.dart';

class ChatBotMessagesList extends StatefulWidget {
  const ChatBotMessagesList({super.key});

  @override
  State<ChatBotMessagesList> createState() => _ChatBotMessagesListState();
}

class _ChatBotMessagesListState extends State<ChatBotMessagesList> {
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

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Consumer<ChatBotProvider>(

      builder: (context, provider, child) {
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
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DateWidget(
                  date: (provider.groupedMessages?.keys.toList() ?? [])[index],
                ),
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
                    return ChatBotMessage(
                      botMessagesModelMessages: provider.groupedMessages![
                          (provider.groupedMessages?.keys.toList() ??
                              [])[index]]![msgIndex],
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

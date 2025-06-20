import 'package:irhebo/presentation/screens/bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/all_chats/all_chats_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/all_chats/widgets/chats_filters_list.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/all_chats/widgets/chats_list.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/all_chats/widgets/chats_shimmer.dart';
import 'package:irhebo/presentation/widgets/app_text_field.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';

import '../../../../../app/global_imports.dart';
import '../../../../../domain/providers/chat/chat_provider.dart';

class AllChatsScreen extends GetView<AllChatsController> {
  const AllChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: NormalAppBar(
        title: "Chats",
        hasLeading: true,
        onTapBack: () => Get.find<BottomNavBarController>().onWillPop(false),
      ),
      body: Consumer<ChatProvider>(
        builder: (context, provider, child) {
          return Visibility(
            visible: !provider.isLoadingGetChatList,
            replacement: Column(
              children: [for (int i = 0; i < 8; i++) const ChatsShimmer()],
            ),
            child: RefreshIndicator(
              onRefresh: () async {
                await provider.getChatList();
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  // Padding(
                  //   padding: EdgeInsets.only(bottom: 3.98 * (w / 100)),
                  //   child: AppTextField(
                  //     controller: controller.searchController,
                  //     hint: "Search here",
                  //     isSearch: true,
                  //     isChat: true,
                  //   ),
                  // ),
                  ChatsFiltersList(),
                  ChatsList()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

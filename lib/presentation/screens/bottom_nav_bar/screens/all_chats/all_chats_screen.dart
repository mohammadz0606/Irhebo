import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/all_chats/all_chats_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/all_chats/widgets/chats_filters_list.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/all_chats/widgets/chats_list.dart';
import 'package:irhebo/presentation/widgets/app_text_field.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 3.98 * (w / 100)),
              child: AppTextField(
                controller: controller.searchController,
                hint: "Search here",
                isSearch: true,
                isChat: true,
              ),
            ),
            ChatsFiltersList(),
            ChatsList()
          ],
        ),
      ),
    );
  }
}

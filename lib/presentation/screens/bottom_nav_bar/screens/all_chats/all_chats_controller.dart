import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/global_imports.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/domain/entities/chat_entity.dart';
import 'package:irhebo/domain/params/new_params/chat/toggle_param.dart';

import '../../../../../domain/providers/chat/chat_provider.dart';

class AllChatsController extends GetxController {
  TextEditingController searchController = TextEditingController();
  final Rx<ChatsTabs> _selectedTab = ChatsTabs.All.obs;

  ChatsTabs get selectedTab => _selectedTab.value;

  set selectedTab(value) => _selectedTab.value = value;
  final RxBool _isLoading = false.obs;

  final RxList<ChatEntity> _chats = <ChatEntity>[
    ChatEntity(
        name: "Leen Saleh",
        id: "1",
        message:
            "Lorem ipsum dolor sit amet consectetur. Faucibus viverra et tempus et scelerisque fringilla erat purus. Sed id tincidunt risus et justo.",
        image: AppImages.placeholder,
        timestamp: "2024/24/04",
        type: "Spam"),
    ChatEntity(
        name: "Christeen Saleh",
        id: "2",
        message:
            "Lorem ipsum dolor sit amet consectetur. Faucibus viverra et tempus et scelerisque fringilla erat purus. Sed id tincidunt risus et justo.",
        image: AppImages.placeholder,
        timestamp: "2024/24/04",
        type: "Starred"),
    ChatEntity(
        name: "Samiah Saleh",
        id: "3",
        message:
            "Lorem ipsum dolor sit amet consectetur. Faucibus viverra et tempus et scelerisque fringilla erat purus. Sed id tincidunt risus et justo.",
        image: AppImages.placeholder,
        timestamp: "2024/24/04",
        type: "Unread"),
    ChatEntity(
        name: "Roshen Saleh",
        id: "4",
        message:
            "Lorem ipsum dolor sit amet consectetur. Faucibus viverra et tempus et scelerisque fringilla erat purus. Sed id tincidunt risus et justo.",
        image: AppImages.placeholder,
        timestamp: "2024/24/04",
        type: "Unread"),
    ChatEntity(
        name: "Carolin Saleh",
        id: "5",
        message:
            "Lorem ipsum dolor sit amet consectetur. Faucibus viverra et tempus et scelerisque fringilla erat purus. Sed id tincidunt risus et justo.",
        image: AppImages.placeholder,
        timestamp: "2024/24/04",
        type: "Unread"),
    ChatEntity(
        name: "Oeter Saleh",
        id: "6",
        message:
            "Lorem ipsum dolor sit amet consectetur. Faucibus viverra et tempus et scelerisque fringilla erat purus. Sed id tincidunt risus et justo.",
        image: AppImages.placeholder,
        timestamp: "2024/24/04",
        type: "Unread"),
    ChatEntity(
        name: "Ali Saleh",
        id: "7",
        message:
            "Lorem ipsum dolor sit amet consectetur. Faucibus viverra et tempus et scelerisque fringilla erat purus. Sed id tincidunt risus et justo.",
        image: AppImages.placeholder,
        timestamp: "2024/24/04",
        type: "Unread"),
    ChatEntity(
        name: "Sami Saleh",
        id: "8",
        message:
            "Lorem ipsum dolor sit amet consectetur. Faucibus viverra et tempus et scelerisque fringilla erat purus. Sed id tincidunt risus et justo.",
        image: AppImages.placeholder,
        timestamp: "2024/24/04",
        type: "Unread"),
    ChatEntity(
        name: "Alaa Saleh",
        id: "9",
        message:
            "Lorem ipsum dolor sit amet consectetur. Faucibus viverra et tempus et scelerisque fringilla erat purus. Sed id tincidunt risus et justo.",
        image: AppImages.placeholder,
        timestamp: "2024/24/04",
        type: "Unread"),
  ].obs;

  // ignore: invalid_use_of_protected_member
  List<ChatEntity> get chats => _chats.value;

  bool get isLoading => _isLoading.value;

  set chats(value) => _chats.value = value;

  set isLoading(value) => _isLoading.value = value;

  @override
  onInit() async {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChatProvider>(Get.context!, listen: false).getChatList();
    });
  }

  onDeleteChat(int i) {
    chats.removeAt(i);
    _chats.refresh();
  }

  onChangeStatus(int value, int i) {
    switch (value) {
      case 1:
        chats.removeAt(i);

      case 2:
        chats[i].type = "Spam";
        Provider.of<ChatProvider>(Get.context!, listen: false).toggleFlag(
            ToggleParam(
                flag: 'spam',
                chatId:   i.toString(),
            )


        );

      case 3:
        chats[i].type = "Starred";
        Provider.of<ChatProvider>(Get.context!, listen: false).toggleFlag(
          ToggleParam(
            flag: 'stared',
            chatId:    i.toString(),
          )


        );

    }
    _chats.refresh();
  }

  onTapMoreOnChat(int i) {}

  onChangeTab(ChatsTabs tab) {
    selectedTab = tab;
    _selectedTab.refresh();
  }
}

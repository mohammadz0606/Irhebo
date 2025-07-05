import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:irhebo/app/global_imports.dart';
import 'package:irhebo/domain/params/new_params/chat/toggle_param.dart';

import '../../../app/chat_pusher/chat_pusher_config.dart';
import '../../../app/network/network.dart';
import '../../../app/router/routes.dart';
import '../../models/new_models/chat/chat_list_model.dart';
import '../../models/new_models/chat/chat_messages_model.dart';
import '../../models/new_models/chat/start_chat_model.dart';
import '../../params/new_params/chat/send_message_param.dart';

class ChatProvider extends ChangeNotifier {
  //chat-{client-id}-{freelancer-id}

  List<ChatListModelData>? allChatList;
  final List<int> alFreelancerChatId = [];
  bool isLoadingGetChatList = false;
  bool isLoadingSendMessages = false;

  List<ChatMessagesModelDataMessages>? chatMessages;

  ChatAppbar? appbarData;
  bool isLoadingGetChatMessages = false;
  Map<String, List<ChatMessagesModelDataMessages>>? groupedMessages;
  ChatMessagesModelData? chatMessagesModelData;

  bool isLoadingStartChat = false;

  List<ChatListModelData>? allChatListByFilter;
  ChatStatus chatStatus = ChatStatus.all;

  Future<void> getChatList() async {
    try {
      if (allChatList != null) {
        allChatList = null;
        alFreelancerChatId.clear();
        allChatListByFilter = null;
      }
      isLoadingGetChatList = true;
      notifyListeners();
      final response = await Network().get(url: AppEndpoints.getChatList);
      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoadingGetChatList = false;
        notifyListeners();
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        return;
      }

      final ChatListModel chatListModel = ChatListModel.fromJson(response.data);
      allChatList = chatListModel.data;
      allChatListByFilter = chatListModel.data;
      alFreelancerChatId.addAll(allChatList!
          .map(
            (e) => e.receiver?.id ?? 0,
          )
          .toList());
      isLoadingGetChatList = false;
      notifyListeners();
    } catch (error) {
      if (error is DioException) {
        AppSnackBar.openErrorSnackBar(
          message: Network().handelDioException(error),
        );
      } else {
        AppSnackBar.openErrorSnackBar(
          message: error.toString(),
        );
      }

      isLoadingGetChatList = false;
      notifyListeners();
    }
  }

  void filterChat(ChatStatus chatStatus) {
    switch (chatStatus) {
      case ChatStatus.all:
        this.chatStatus = ChatStatus.all;
        allChatListByFilter = allChatList;
        break;
      case ChatStatus.unread:
        this.chatStatus = ChatStatus.unread;
        // allChatListByFilter = allChatList
        //     ?.where((element) => element.chatStatus == ChatStatus.unread)
        //     .toList();
        allChatListByFilter =
            allChatList?.where((element) => element.unreadCount != 0).toList();
        break;
      case ChatStatus.stared:
        this.chatStatus = ChatStatus.stared;
        allChatListByFilter = allChatList
            ?.where((element) => element.chatStatus == ChatStatus.stared)
            .toList();
        break;
      case ChatStatus.spam:
        this.chatStatus = ChatStatus.spam;
        allChatListByFilter = allChatList
            ?.where((element) => element.chatStatus == ChatStatus.spam)
            .toList();
        break;
    }

    notifyListeners();
  }

  Future<void> sendMessage({required SendMessageParam sendParam}) async {
    try {
      isLoadingSendMessages = true;
      notifyListeners();
      final response = await Network().post(
        url: AppEndpoints.sendMessage,
        isUploadFile: sendParam.attachmentFile != null,
        data: await sendParam.toJson(),
      );
      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        isLoadingSendMessages = false;
        notifyListeners();
        return;
      }

      final newMessage =
          ChatMessagesModelDataMessages.fromJsonNew(response.data['data']);
      final formattedDate = formatDate(newMessage.createdAt ?? DateTime.now());
      // chatMessages?.add(
      //   ChatMessagesModelData.fromJson(response.data['data']),
      // );
      groupedMessages?.update(
        formattedDate,
        (existingList) => [newMessage, ...existingList],
        ifAbsent: () => [newMessage],
      );
      isLoadingSendMessages = false;
      notifyListeners();
    } catch (error) {
      if (error is DioException) {
        AppSnackBar.openErrorSnackBar(
          message: Network().handelDioException(error),
        );
      } else {
        AppSnackBar.openErrorSnackBar(
          message: error.toString(),
        );
      }
      isLoadingSendMessages = false;
      notifyListeners();
    }
  }

  Future<void> toggleFlag(ToggleParam param) async {
    try {
      final response = await Network().post(
        url: AppEndpoints.toggleChat,
        data: param.toJson(),
      );
      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        return;
      }
      await getChatList();
    } catch (error) {
      if (error is DioException) {
        AppSnackBar.openErrorSnackBar(
          message: Network().handelDioException(error),
        );
      } else {
        AppSnackBar.openErrorSnackBar(
          message: error.toString(),
        );
      }
    }
  }

  Future<void> getAllMessages({required int chatId}) async {
    try {
      if (chatMessages != null) {
        chatMessages = null;
        chatMessagesModelData = null;
      }

      isLoadingGetChatMessages = true;
      notifyListeners();
      final response =
          await Network().get(url: '${AppEndpoints.getMessages}$chatId');
      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoadingGetChatMessages = false;
        notifyListeners();
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        return;
      }
      ChatMessagesModel chatMessagesModel =
          ChatMessagesModel.fromJson(response.data);

      chatMessages = chatMessagesModel.data?.messages;
      chatMessagesModelData = chatMessagesModel.data;
      _startLiveChat(chatId: chatId);
      _getAppbarData();
      _groupMessages();
      // if (chatMessages?.isNotEmpty == true) {
      //
      // }

      isLoadingGetChatMessages = false;
      notifyListeners();
    } catch (error) {
      if (error is DioException) {
        AppSnackBar.openErrorSnackBar(
          message: Network().handelDioException(error),
        );
      } else {
        AppSnackBar.openErrorSnackBar(
          message: error.toString(),
        );
      }

      isLoadingGetChatMessages = false;
      notifyListeners();
    }
  }

  Future<void> markRead({required int chatId}) async {
    try {
      final response =
          await Network().get(url: '${AppEndpoints.markRead}$chatId');
      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        return;
      }
    } catch (error) {
      if (error is DioException) {
        AppSnackBar.openErrorSnackBar(
          message: Network().handelDioException(error),
        );
      } else {
        AppSnackBar.openErrorSnackBar(
          message: error.toString(),
        );
      }
    }
  }

  Future<void> startChat({required int freelancerId}) async {
    try {
      isLoadingStartChat = true;
      notifyListeners();
      // if (alFreelancerChatId.contains(freelancerId)) {
      //   // AppSnackBar.openErrorSnackBar(
      //   //   message: 'A conversation with the freelancer already exists'.tr,
      //   // );
      //
      //   isLoadingStartChat = false;
      //   notifyListeners();
      //   return;
      // }

      final response = await Network().post(
        url: '${AppEndpoints.startChat}$freelancerId',
      );

      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        isLoadingStartChat = false;
        notifyListeners();
        return;
      }

      StartChatModel startChatModel = StartChatModel.fromJson(response.data);
      Get.toNamed(
        AppRoutes.chat,
        arguments: {
          "chat_type": ChatType.Users,
          'userId': startChatModel.userId ?? 0,
          'chatId': startChatModel.chatId ?? 0,
        },
      );

      isLoadingStartChat = false;
      notifyListeners();
    } catch (error) {
      if (error is DioException) {
        AppSnackBar.openErrorSnackBar(
          message: Network().handelDioException(error),
        );
      } else {
        AppSnackBar.openErrorSnackBar(
          message: error.toString(),
        );
      }
      isLoadingStartChat = false;
      notifyListeners();
    }
  }

  _getAppbarData() {
    if (appbarData != null) {
      appbarData = null;
    }

    AppPreferences preferences = sl();

    int userId = preferences.getInt(key: AppPrefsKeys.USER_ID) ?? 0;

    if (chatMessagesModelData?.sender?.id != userId) {
      appbarData = ChatAppbar(
        id: chatMessagesModelData?.sender?.id,
        username: chatMessagesModelData?.sender?.username,
        avatar: chatMessagesModelData?.sender?.avatar,
      );
    } else {
      appbarData = ChatAppbar(
        id: chatMessagesModelData?.receiver?.id,
        username: chatMessagesModelData?.receiver?.username,
        avatar: chatMessagesModelData?.receiver?.avatar,
      );
    }

    notifyListeners();
  }

  void _groupMessages() {
    if (groupedMessages != null) {
      groupedMessages = null;
    }
    Map<String, List<ChatMessagesModelDataMessages>> grouped = {};

    chatMessages?.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    for (var message in chatMessages ?? []) {
      //String formattedDate = formatDate(DateTime.parse(message.createdAt ?? DateTime.now()));
      String formattedDate = formatDate(message.createdAt ?? DateTime.now());
      grouped.putIfAbsent(formattedDate, () => []).add(message);
    }

    groupedMessages = grouped;
    notifyListeners();
  }

  _startLiveChat({required int chatId}) async {
    await ChatPusherConfig().init(
      onEvent: (event) {
        log('-----------');
        log('START CHAT');
        log('channelName: ${event.channelName}');
        log('eventName: ${event.eventName}');
        log('data: ${event.data}');
        log('-----------');
        if (event.eventName == 'message.sent') {
          try {
            // final raw = json.decode(event.data);
            // final messageMap = raw['message'] as Map<String, dynamic>;
            // //chatMessages?.add(ChatMessagesModelData.fromJsonNew(messageMap));
            // String formattedDate = formatDate(DateTime.now());
            // groupedMessages?.putIfAbsent(formattedDate, () => []).add(
            //       ChatMessagesModelData.fromJsonNew(messageMap),
            //     );

            final raw = json.decode(event.data);
            final messageMap = raw['message'] as Map<String, dynamic>;
            final newMessage =
                ChatMessagesModelDataMessages.fromJsonNew(messageMap);
            final formattedDate =
                formatDate(newMessage.createdAt ?? DateTime.now());

            AppPreferences preferences = sl();

            int userId = preferences.getInt(key: AppPrefsKeys.USER_ID) ?? 0;

            if (newMessage.sender?.id != userId) {
              groupedMessages?.update(
                formattedDate,
                (existingList) => [newMessage, ...existingList],
                ifAbsent: () => [newMessage],
              );
            }
            notifyListeners();
          } catch (error) {
            log(error.toString());
          }
        }
      },
    );
    await ChatPusherConfig().subscribeToChannel(
      chatId: chatId,
    );

    //ChatPusherConfig().onEvent();
  }
}

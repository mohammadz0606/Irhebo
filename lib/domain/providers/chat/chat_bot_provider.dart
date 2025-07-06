import 'package:dio/dio.dart';
import 'package:irhebo/app/global_imports.dart';

import '../../../app/network/network.dart';
import '../../models/new_models/chat/chat_bot_messages_model.dart';
import '../../models/new_models/chat/send_chat_bot_message_model.dart';

class ChatBotProvider extends ChangeNotifier {
  bool isLoadingSendMessages = false;
  bool isLoadingGetMessages = false;
  List<BotMessagesModelMessages>? chatBotMessages;
  Map<String, List<BotMessagesModelMessages>>? groupedMessages;

  Future<void> sendMessage({
    required String message,
    required ChatBotType chatBotType,
  }) async {
    try {
      isLoadingSendMessages = true;
      final date = DateTime.now();
      BotMessagesModelMessages newMessageUser = BotMessagesModelMessages(
        id: date.microsecondsSinceEpoch,
        role: 'user',
        message: message.trim(),
        createdAt: date,
        services: [],
      );
      groupedMessages?.update(
        formatDate(date),
        (existingList) => [newMessageUser,...existingList],
        ifAbsent: () => [newMessageUser],
      );
      notifyListeners();

      final response = await Network().post(
        url: AppEndpoints.sendMessageForBot,
        data: {
          'type': chatBotType.name,
          'message': message.trim(),
        },
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

      SendBotMessageModel sendBotMessageModel =
          SendBotMessageModel.fromJson(response.data);

      BotMessagesModelMessages newMessageBot = BotMessagesModelMessages(
        id: sendBotMessageModel.data?.id,
        role: sendBotMessageModel.data?.role,
        message: sendBotMessageModel.data?.message,
        createdAt: sendBotMessageModel.data?.createdAt,
        services: [],
      );
      groupedMessages?.update(
        formatDate(sendBotMessageModel.data?.createdAt ?? DateTime.now()),
            (existingList) => [newMessageBot,...existingList],
        ifAbsent: () => [newMessageBot],
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

  Future<void> getMessages({required ChatBotType chatBotType}) async {
    isLoadingGetMessages = true;

    if (chatBotMessages != null) {
      chatBotMessages = null;
    }
    notifyListeners();
    try {
      final response =
          await Network().get(url: AppEndpoints.getMessagesForBot, query: {
        'type': chatBotType.name,
      });
      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoadingGetMessages = false;
        notifyListeners();
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        return;
      }
      chatBotMessages = BotMessagesModel.fromJson(response.data).messages;
      _groupMessages();
      isLoadingGetMessages = false;
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

      isLoadingGetMessages = false;
      notifyListeners();
    }
  }

  void _groupMessages() {
    if (groupedMessages != null) {
      groupedMessages = null;
      notifyListeners();
    }
    Map<String, List<BotMessagesModelMessages>> grouped = {};

    chatBotMessages?.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    for (var message in chatBotMessages ?? []) {
      //String formattedDate = formatDate(DateTime.parse(message.createdAt ?? DateTime.now()));
      String formattedDate = formatDate(message.createdAt ?? DateTime.now());
      grouped.putIfAbsent(formattedDate, () => []).add(message);
    }

    groupedMessages = grouped;
    notifyListeners();
  }
}

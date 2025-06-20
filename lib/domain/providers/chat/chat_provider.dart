import 'package:dio/dio.dart';
import 'package:irhebo/app/global_imports.dart';

import '../../../app/network/network.dart';
import '../../models/new_models/chat/chat_list_model.dart';

class ChatProvider extends ChangeNotifier {

  //chat-{client-id}-{freelancer-id}


  List<ChatListModelData>? allChatList;
  bool isLoadingGetChatList = false;

  getChatList() async {
    try {
      if (allChatList != null) {
        allChatList = null;
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
}

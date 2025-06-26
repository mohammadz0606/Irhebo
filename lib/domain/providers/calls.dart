import 'package:dio/dio.dart';
import 'package:irhebo/app/global_imports.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/domain/models/new_models/calls/end_call.dart';

import '../../app/calls/agora_configuration.dart';
import '../../app/network/network.dart';
import '../models/new_models/calls/start_call.dart';

class CallsProvider extends ChangeNotifier {
  bool isLoadingStartCall = false;
  bool isLoadingAnswerCall = false;
  bool isLoadingEndCall = false;

  int callId = 0;

  Future<void> startCall({required int receiverId}) async {
    try {
      callId = 0;
      isLoadingStartCall = true;
      notifyListeners();
      final response = await Network().post(
        url: AppEndpoints.startCall,
        data: {
          'receiver_id': receiverId.toString(),
        },
      );

      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoadingStartCall = false;
        notifyListeners();
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        return;
      }

      StartAndAnswerCallModel startCallModel = StartAndAnswerCallModel.fromJson(response.data);
      callId = startCallModel.data?.call?.id ?? 0;

      AppPreferences preferences = sl();

      int userID = preferences.getInt(key: AppPrefsKeys.USER_ID) ?? 0;

      await AgoraConfiguration().initAgora(
        token: startCallModel.data?.token ?? '',
        channelName: startCallModel.data?.call?.channelName ?? '',
        userID: userID,
        onUserAccepted: () async {
          //await answerCall();
        },
        onUserEndCall: () async {
          await endCall();
        },
      );
      Get.toNamed(AppRoutes.call);
      isLoadingStartCall = false;
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
      isLoadingStartCall = false;
      notifyListeners();
    }
  }

  Future<void> answerCall() async {
    try {
      isLoadingAnswerCall = true;
      notifyListeners();
      final response = await Network().post(
        url: AppEndpoints.answerCall,
        data: {
          'call_id': callId,
        },
      );

      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoadingAnswerCall = false;
        notifyListeners();
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        return;
      }

      StartAndAnswerCallModel answerCallModel = StartAndAnswerCallModel.fromJson(response.data);

      callId = answerCallModel.data?.call?.id ?? 0;

      AppPreferences preferences = sl();

      int userID = preferences.getInt(key: AppPrefsKeys.USER_ID) ?? 0;

      await AgoraConfiguration().initAgora(
        token: answerCallModel.data?.token ?? '',
        channelName: answerCallModel.data?.call?.channelName ?? '',
        userID: userID,
        onUserAccepted: () async {
         // await answerCall();
        },
        onUserEndCall: () async {
          await endCall();
        },
      );

      isLoadingAnswerCall = false;
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
      isLoadingAnswerCall = false;
      notifyListeners();
    }
  }

  Future<void> endCall() async {
    try {
      isLoadingEndCall = true;
      notifyListeners();
      final response = await Network().post(
        url: AppEndpoints.endCall,
        data: {
          'call_id': callId.toString(),
        },
      );

      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoadingEndCall = false;
        notifyListeners();
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        return;
      }

      EndCallModel endCallModel = EndCallModel.fromJson(response.data);

      isLoadingEndCall = false;
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
      isLoadingEndCall = false;
      notifyListeners();
    }
  }
}

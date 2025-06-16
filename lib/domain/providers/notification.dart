import 'package:dio/dio.dart';
import 'package:irhebo/app/global_imports.dart';

import '../../app/network/network.dart';
import '../../presentation/screens/notifications/notifications_controller.dart';

class NotificationProvider extends ChangeNotifier {
  bool isNotifiable = true;

  bool isLoadingMarkAsRead = false;

  Future<bool> getNotificationStatus() async {
    AppPreferences prefs = sl();
    bool isNotifiable = prefs.getBoolValue(AppPrefsKeys.IS_NOTIFIABLE);
    this.isNotifiable = isNotifiable;
    return this.isNotifiable;
  }

  Future<void> changeNotifiable() async {
    try {
      AppPreferences prefs = sl();
      final response =
          await Network().post(url: AppEndpoints.changeNotifiable, data: {
        'player_id': prefs.getString(key: AppPrefsKeys.NOTIFICATION_KEY),
      });
      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        return;
      }

      bool isNotifiable = prefs.getBoolValue(AppPrefsKeys.IS_NOTIFIABLE);
      prefs.setBoolValue(!isNotifiable, AppPrefsKeys.IS_NOTIFIABLE);
      getNotificationStatus();
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

  Future<void> markAsRead(int id) async {
    try {
      isLoadingMarkAsRead = true;
      final response =
          await Network().put(url: '${AppEndpoints.markAsRead}$id');

      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoadingMarkAsRead = false;

        notifyListeners();

        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        return;
      }
      isLoadingMarkAsRead = false;
      await Get.find<NotificationsController>().onRefreshList();
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

      isLoadingMarkAsRead = false;
      notifyListeners();
    }
  }
}

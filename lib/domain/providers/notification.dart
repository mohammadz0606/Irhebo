import 'package:dio/dio.dart';
import 'package:irhebo/app/global_imports.dart';

import '../../app/network/network.dart';
import '../../app/router/routes.dart';
import '../../presentation/screens/bottom_nav_bar/screens/requests/requests_controller.dart';
import '../../presentation/screens/notifications/notifications_controller.dart';
import '../../presentation/screens/request_details/request_details_controller.dart';
import '../../presentation/screens/service_details/service_details_screen.dart';
import '../../presentation/screens/support_tickets/support_tickets_controller.dart';

class NotificationProvider extends ChangeNotifier {
  bool isNotifiable = true;

  bool isLoadingMarkAsRead = false;

  bool navigateToLoading = false;

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

  void navigationTo({
    required int? id,
    required NotificationType? notificationType,
  }) async {
    if (notificationType == null) {
      return;
    }
    navigateToLoading = true;
    notifyListeners();
    switch (notificationType) {
      case NotificationType.request:
        await Get.find<RequestsController>()
            .navigateToRequestDetailsWithId(id ?? 0);
        navigateToLoading = false;
        notifyListeners();
        break;
      case NotificationType.requestLog:
        await Get.find<RequestDetailsController>()
            .getRequestDetails(id)
            .then((value) {
          Get.toNamed(
            AppRoutes.requestHistory,
            arguments: {
              "logs": Get.find<RequestDetailsController>().request.logs,
            },
          );
          navigateToLoading = false;
          notifyListeners();
        });

        break;
      case NotificationType.newFreelancer:
        Get.toNamed(AppRoutes.createService);
        navigateToLoading = false;
        notifyListeners();
        break;
      case NotificationType.rate:
        Get.to(() => const ServiceDetailsScreen(), arguments: {
          "id": id,
        });

        navigateToLoading = false;
        notifyListeners();
        break;
      case NotificationType.quotation:
        Get.toNamed(AppRoutes.quotationDetails, arguments: {
          "id": id,
          "title": '',
        });
        navigateToLoading = false;
        notifyListeners();
        break;
      case NotificationType.chat:
        navigateToLoading = false;
        notifyListeners();
        break;
      case NotificationType.call:
        navigateToLoading = false;
        notifyListeners();
        break;
      case NotificationType.verified:
        Get.toNamed(AppRoutes.profile);
        navigateToLoading = false;
        notifyListeners();
        break;
      case NotificationType.support:
        await Get.find<SupportTicketsController>().getTickets().then((value) {
          var data = Get.find<SupportTicketsController>()
              .tickets
              .firstWhere((element) => element.id == id);

          Get.toNamed(
            AppRoutes.ticketDetails,
            arguments: {
              "id": data.id,
              "ticket": data,
            },
          );

          navigateToLoading = false;
          notifyListeners();
        });

        break;
      case NotificationType.service:
        Get.to(() => const ServiceDetailsScreen(), arguments: {
          "id": id,
        });
        navigateToLoading = false;
        notifyListeners();
        break;
      case NotificationType.portfolio:
        Get.toNamed(AppRoutes.portfolioDetails, arguments: {
          "id": id,
          "title": '',
        });

        navigateToLoading = false;
        notifyListeners();
        break;
    }
  }
}

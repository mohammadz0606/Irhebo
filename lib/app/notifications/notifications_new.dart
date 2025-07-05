import 'package:dio/src/response.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../domain/models/new_models/calls/start_call.dart';
import '../../presentation/screens/bottom_nav_bar/screens/requests/requests_controller.dart';
import '../../presentation/screens/request_details/request_details_controller.dart';
import '../../presentation/screens/service_details/service_details_screen.dart';
import '../../presentation/screens/support_tickets/support_tickets_controller.dart';

import '../calls/agora_configuration.dart';
import '../global_imports.dart';
import '../network/network.dart';
import '../router/routes.dart';

final class Notifications {
  /// Singleton class

  Notifications._();

  static final Notifications _instance = Notifications._();

  factory Notifications() {
    return _instance;
  }

  Future<void> init() async {
    OneSignal.initialize('7ab59a87-79f3-46e8-af69-673331be40cc');
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.LiveActivities.setupDefault();
    await OneSignal.Notifications.requestPermission(false);
    await getId();

    _navigationOnClick();
  }

  Future<String?>? getId() async {
    await Future.delayed(const Duration(seconds: 1));
    final String? subscriptionId = OneSignal.User.pushSubscription.id;
    if (subscriptionId != null) {
      AppPreferences prefs = sl();
      prefs.setString(
          key: AppPrefsKeys.NOTIFICATION_KEY, value: subscriptionId);
      OneSignal.login(subscriptionId);
    }
    return subscriptionId;
  }

  void _navigationOnClick() {
    return OneSignal.Notifications.addClickListener(
      (event) async {
        final additionalData = event.notification.additionalData;
        int? id = additionalData?['type_id'];
        NotificationType? type =
            notificationTypeFromString(additionalData?['type'] as String?);
        final actionId = event.result.actionId;

        if (actionId != null) {
          if (actionId == 'accept_button') {
            await _onCall(id: id ?? 0);
          } else if (actionId == 'decline_button') {
            final response = await Network().post(
              url: AppEndpoints.endCall,
              data: {
                'call_id': id,
              },
            );
          }
        }

        if (type == null) {
          return;
        }
        switch (type) {
          case NotificationType.request:
            await Get.find<RequestsController>()
                .navigateToRequestDetailsWithId(id ?? 0);

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
            });

            break;
          case NotificationType.newFreelancer:
            Get.toNamed(AppRoutes.createService);

            break;
          case NotificationType.rate:
            Get.to(() => const ServiceDetailsScreen(), arguments: {
              "id": id,
            });

            break;
          case NotificationType.quotation:
            Get.toNamed(AppRoutes.quotationDetails, arguments: {
              "id": id,
              "title": '',
            });

            break;
          case NotificationType.chat:
            Get.toNamed(
              AppRoutes.chat,
              arguments: {
                "chat_type": ChatType.Users,
                // 'userId': startChatModel.userId ?? 0,
                'chatId': id,
              },
            );
            break;
          case NotificationType.call:
            await _onCall(id: id ?? 0);
            break;
          case NotificationType.verified:
            Get.toNamed(AppRoutes.profile);

            break;
          case NotificationType.support:
            await Get.find<SupportTicketsController>()
                .getTickets()
                .then((value) {
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
            });

            break;
          case NotificationType.service:
            Get.to(() => const ServiceDetailsScreen(), arguments: {
              "id": id,
            });

            break;
          case NotificationType.portfolio:
            Get.toNamed(AppRoutes.portfolioDetails, arguments: {
              "id": id,
              "title": '',
            });

            break;
        }
      },
    );
  }

  Future<void> _onCall({required int id}) async {
    final response = await Network().post(
      url: AppEndpoints.answerCall,
      data: {
        'call_id': id,
      },
    );
    StartAndAnswerCallModel answerCallModel =
        StartAndAnswerCallModel.fromJson(response.data);
    AppPreferences preferences = sl();

    int userID = preferences.getInt(key: AppPrefsKeys.USER_ID) ?? 0;
    int callId = answerCallModel.data?.call?.id ?? 0;

    await AgoraConfiguration().initAgora(
      token: answerCallModel.data?.token ?? '',
      channelName: answerCallModel.data?.call?.channelName ?? '',
      userID: userID,
      onUserAccepted: () async {},
      onUserEndCall: () async {
        Get.back();
        final response = await Network().post(
          url: AppEndpoints.endCall,
          data: {
            'call_id': callId,
          },
        );
        await AgoraConfiguration().leaveCall();
      },
    );

    Get.toNamed(AppRoutes.call, arguments: {
      'call_id': callId,
    });
  }
}

import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../../presentation/screens/bottom_nav_bar/screens/requests/requests_controller.dart';
import '../../presentation/screens/request_details/request_details_controller.dart';
import '../enums.dart';
import '../injection.dart';
import '../router/routes.dart';
import '../storage/app_prefs.dart';
import '../storage/app_prefs_keys.dart';

final class Notifications {
  /// Singleton class

  Notifications._();

  static final Notifications _instance = Notifications._();

  factory Notifications() {
    return _instance;
  }

  Future<void> init() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize('7ab59a87-79f3-46e8-af69-673331be40cc');

    OneSignal.LiveActivities.setupDefault();
    await OneSignal.Notifications.requestPermission(false);

    await getId();
  }

  Future<String?>? getId() async {
    // var onesignalId = Platform.isIOS
    //     ? await OneSignal.User.getExternalId()
    //     : await OneSignal.User.getOnesignalId();
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


}

import 'package:onesignal_flutter/onesignal_flutter.dart';

final class Notifications {
  /// Singleton class

  Notifications._();

  static final Notifications _instance = Notifications._();

  factory Notifications() {
    return _instance;
  }

  init() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize('7ab59a87-79f3-46e8-af69-673331be40cc');
    OneSignal.LiveActivities.setupDefault();
    await OneSignal.Notifications.requestPermission(false);
    getId();
  }

  Future<String?>? getId() async {
    var onesignalId = await OneSignal.User.getOnesignalId();
    OneSignal.login(onesignalId!);
    return onesignalId;
  }
}

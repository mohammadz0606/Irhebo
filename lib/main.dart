import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:irhebo/app/app.dart';
import 'package:irhebo/app/injection.dart';

import 'app/network/network.dart';
import 'app/notifications/notifications_new.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Network().init();

  await init();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Notifications().init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(Irhebo());
}

// Future<void> initOneSignal() async {
//   OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
//   OneSignal.initialize('592316cd-ef7f-44c2-83af-00051ed3783f');
//   OneSignal.InAppMessages.paused(true);
//   OneSignal.Notifications.requestPermission(true);
// }

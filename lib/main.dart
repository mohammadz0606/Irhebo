import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:irhebo/app/app.dart';
import 'package:irhebo/app/injection.dart';

import 'app/network/network.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await ScreenUtil.ensureScreenSize();
  // await initOneSignal();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  Network().init();
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

// ignore_for_file: must_be_immutable

import 'package:bot_toast/bot_toast.dart';
import 'package:cupertino_back_gesture/cupertino_back_gesture.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'package:irhebo/app/connection_internet.dart';
import 'package:irhebo/app/global_imports.dart';
import 'package:irhebo/app/notifications/notifications_service.dart';
import 'package:irhebo/app/providers.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/app/router/screens.dart';
import 'package:oktoast/oktoast.dart';
import 'package:showcaseview/showcaseview.dart';

import '../presentation/widgets/scroll_behavior.dart';

class Irhebo extends StatelessWidget {
  Irhebo._internal(); // private named constructor
  int appState = 0;
  static final Irhebo instance =
      Irhebo._internal(); // single instance -- singleton

  factory Irhebo() => instance; // factory for the class instance
  final botToastBuilder = BotToastInit();
  final navigatorKey = GlobalKey<NavigatorState>();

  // bool light = true;

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return OKToast(
      child: BackGestureWidthTheme(
        backGestureWidth: BackGestureWidth.fraction(1 / 2),
        child: MultiProvider(
          providers: providers,
          child: ScreenUtilInit(
            designSize: const Size(402, 874), //1800
            minTextAdapt: true,
            splitScreenMode: false,
            builder: (BuildContext context, Widget? child) {
              return Obx(
                () => GetMaterialApp(
                  title: 'irhebo',
                  debugShowCheckedModeBanner: false,
                  getPages: AppScreens.screens,
                  initialRoute: AppRoutes.splash,
                  initialBinding: RootBinding(),
                  scrollBehavior: AppScrollBehavior(),
                  themeMode: Get.find<AppController>().darkMode
                      ? ThemeMode.dark
                      : ThemeMode.light,
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  locale: Get.find<AppController>().lang.value,
                  fallbackLocale: LocalizationService.fallbackLocale,
                  translations: LocalizationService(),
                  navigatorKey: GlobalVariable.navState,
                  supportedLocales: LocalizationService.locales,

                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    FlutterQuillLocalizations.delegate,
                  ],
                  builder: (context, child) {
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                          textScaler: TextScaler.linear(
                        1.sp,
                      )),
                      child: ShowCaseWidget(
                        builder: (context) => botToastBuilder(context, child),
                      ),
                    );
                  },
                  // navigatorObservers: [CustomNavigatorObserver()],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(NotificationsService(), permanent: true);
    Get.put(ConnectionManagerController(), permanent: true);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/all_chats/all_chats_screen.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/home_screen.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/requests/requests_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/requests/requests_screen.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/settings/settings_screen.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/wishlist/wishlist_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/wishlist/wishlist_screen.dart';
import 'package:irhebo/presentation/widgets/app_dialog.dart';
import 'package:irhebo/presentation/widgets/login_required_dialog.dart';

class BottomNavBarController extends GetxController {
  final appController = Get.find<AppController>();

  // GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  // PageController pageController = PageController(initialPage: 2);

  final RxInt _index = 2.obs;

  int get index => _index.value;

  set index(value) {
    if (_index.value != value) {
      _index.value = value;
      // log(value.toString());
      _index.value = value;
    }
  }

  onChangeIndex(int value) async {
    if ((value == 0 || value == 1 || value == 3) &&
        appController.token.isEmpty) {
      Get.dialog(
        barrierColor: Get.find<AppController>().darkMode
            ? AppDarkColors.darkContainer.withOpacity(0.3)
            : AppLightColors.shadow.withOpacity(0.3),
        const AppDialog(
          child: LoginRequiredDialog(),
        ),
      );
    } else {
      index = value;
      if (index == 3) {
        Get.find<WishlistController>().getServices();
      }
      if (index == 0) {
        Get.find<RequestsController>().getRequests();
      }
      if (Get.isSnackbarOpen) {
        Get.back();
      }
    }
  }

  final List<Widget> pages = <Widget>[
    const RequestsScreen(),
    const AllChatsScreen(),
    const HomeScreen(),
    const WishlistScreen(),
    const SettingsScreen(),
  ];
  DateTime? currentBackPressTime;

  // AppNavigationBarController appNavigationBarController =
  //     AppNavigationBarController();

  void onWillPop(bool didPop) {
    if (didPop) {
      return;
    }
    if (index != 2) {
      index = 2;
      return;
    }
    bool value = checkTime();
    if (value) {
      SystemNavigator.pop();
    }
  }

  bool checkTime() {
    bool value = false;
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Tap back again to leave'.tr,
        backgroundColor: Get.find<AppController>().darkMode
            ? AppDarkColors.greenContainer
            : AppLightColors.primaryColor,
      );
      return value;
      // return Future.value(false);
    }
    return true;
  }
}

import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/all_chats/all_chats_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/home_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/requests/requests_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/settings/settings_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/wishlist/wishlist_controller.dart';

import '../auth/login/login_controller.dart';

class BottomNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavBarController());
    Get.put(HomeController());
    Get.put(SettingsController());
    Get.put(RequestsController());
    Get.put(WishlistController());
    Get.put(AllChatsController());
    Get.put(LoginController());
    // Get.lazyPut(() => BottomNavBarController());
    // Get.lazyPut(() => HomeController());
    // Get.lazyPut(() => WishlistController());
    // Get.lazyPut(() => RequestsController());
    // Get.lazyPut(() => AllChatsController());
    // Get.lazyPut(() => SettingsController());
  }
}

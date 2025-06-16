import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/global_imports.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/domain/usecases/auth_usecases/logout_use_case.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/settings/widgets/logout_bottom_sheet.dart';
import 'package:irhebo/presentation/widgets/app_bottom_sheet.dart';
import 'package:irhebo/presentation/widgets/app_dialog.dart';
import 'package:irhebo/presentation/widgets/language_bottom_sheet.dart';
import 'package:irhebo/presentation/widgets/login_required_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../app/storage/app_prefs.dart';
import '../../../../../app/storage/app_prefs_keys.dart';
import '../../../../../domain/providers/notification.dart';

class SettingsController extends GetxController {
  final appController = Get.find<AppController>();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final RxBool _noti = true.obs;
  final RxBool isLoadingLogout = false.obs;
  final RxBool _darkTheme = false.obs;

  bool get noti => _noti.value;

  bool get darkTheme => _darkTheme.value;

  set noti(value) => _noti.value = value;

  set darkTheme(value) => _darkTheme.value = value;

  // ignore: invalid_use_of_protected_member
  dio.MultipartFile? atthach;

  bool isLoading = false;
  bool isLoadingPassword = false;

  // ignore: invalid_use_of_protected_member

  @override
  onInit() async {
    bool isNotifiable = await Provider.of<NotificationProvider>(Get.context!)
        .getNotificationStatus();
    _noti.value = isNotifiable;
    super.onInit();
  }

  onToggleNotifications(bool value) async {
    noti = !noti;
    await Provider.of<NotificationProvider>(Get.context!,listen: false).changeNotifiable();
  }

  onToggleMode(bool value) async {
    darkTheme = value;
    _darkTheme.refresh();
    appController.onChangeThemeMode(value);
  }

  void openLanguageBottomSheet() {
    if (Get.context != null && Get.context!.mounted) {
      Get.bottomSheet(
        const AppBottomSheet(title: "Languages", child: LanguageBottomSheet()),
        backgroundColor: Get.find<AppController>().darkMode
            ? AppDarkColors.darkScaffoldColor
            : AppLightColors.pureWhite,
        barrierColor: Get.find<AppController>().darkMode
            ? AppDarkColors.darkContainer.withOpacity(0.3)
            : AppLightColors.shadow.withOpacity(0.3),
        elevation: 0,
        isScrollControlled: false,
      );
    }
  }

  void openLogoutBottomSheet() {
    if (Get.context != null && Get.context!.mounted) {
      Get.bottomSheet(
        const AppBottomSheet(title: "Logout", child: LogoutBottomSheet()),
        backgroundColor: Get.find<AppController>().darkMode
            ? AppDarkColors.darkScaffoldColor
            : AppLightColors.pureWhite,
        barrierColor: Get.find<AppController>().darkMode
            ? AppDarkColors.darkContainer.withOpacity(0.3)
            : AppLightColors.shadow.withOpacity(0.3),
        elevation: 0,
        isScrollControlled: false,
      );
    }
  }

  logout() async {
    isLoadingLogout.value = true;
    LogoutUseCase logoutUseCase = sl();
    final result = await logoutUseCase(());
    result!.fold((l) {
      isLoadingLogout.value = false;
    }, (r) {
      isLoadingLogout.value = false;
      appController.removeToken();
      AppPreferences pref = sl();
      pref.removeItem(AppPrefsKeys.USER_ROLE);
      pref.removeItem(AppPrefsKeys.IS_NOTIFIABLE);
      Get.offAllNamed(AppRoutes.splash);
    });
  }

  onTapSupportTickets() {
    if (appController.token.isNotEmpty) {
      Get.toNamed(AppRoutes.supportTickets);
    } else {
      openLoginRequiredDialog();
    }
  }

  onTapQuotations() {
    if (appController.token.isNotEmpty) {
      Get.toNamed(AppRoutes.quotations);
    } else {
      openLoginRequiredDialog();
    }
  }

  goToProfile() async {
    Get.toNamed(AppRoutes.profile);
  }

  openLoginRequiredDialog() {
    Get.dialog(
      barrierColor: Get.find<AppController>().darkMode
          ? AppDarkColors.darkContainer.withOpacity(0.3)
          : AppLightColors.shadow.withOpacity(0.3),
      const AppDialog(
        child: LoginRequiredDialog(),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/app/storage/app_prefs_keys.dart';
import 'package:irhebo/domain/models/slider_model.dart';
import 'package:irhebo/domain/usecases/intro_usecases/get_steps_use_case.dart';
import 'package:irhebo/presentation/screens/intro/screens/language_screen.dart';
import 'package:irhebo/presentation/screens/intro/screens/roles_screen.dart';
import 'package:irhebo/presentation/screens/intro/screens/steps_screen.dart';

class SplashController extends GetxController {
  final appController = Get.find<AppController>();

  PageController controller = PageController(initialPage: 0);

  final RxInt _pageIndex = 0.obs;
  final RxBool _isLoadingSteps = false.obs;
  final RxInt _selectedRoleIndex = (0).obs;
  List<SliderModel> steps = [];

  int get pageIndex => _pageIndex.value;
  bool get isLoadingSteps => _isLoadingSteps.value;
  int get selectedRoleIndex => _selectedRoleIndex.value;

  set pageIndex(value) => _pageIndex.value = value;
  set isLoadingSteps(value) => _isLoadingSteps.value = value;
  set selectedRoleIndex(value) => _selectedRoleIndex.value = value;

  @override
  onInit() async {
    super.onInit();
    Timer(const Duration(seconds: 2), () async {
      await appController.getGeneral();
      if (!(Get.find<AppController>()
          .getBoolValue(AppPrefsKeys.LANGUAGE_DIALOG))) {
        Get.to(() => LanguageScreen());
      } else {
        checkIfGoToSteps();
      }
    });
  }

  onChangeRole(int i) {
    selectedRoleIndex = i;
    // Get.toNamed(AppRoutes.steps);
  }

  final RxInt _selectedLangIndex = 0.obs;

  int get selectedLangIndex => _selectedLangIndex.value;

  set selectedLangIndex(value) => _selectedLangIndex.value = value;

  onChangeLanguage(int i) {
    selectedLangIndex = i;
    if (selectedLangIndex == 0) {
      appController.onChangeLanguage(AppLanguage.en.name);
    } else {
      appController.onChangeLanguage(AppLanguage.ar.name);
    }
    // Get.toNamed(AppRoutes.steps);
  }

  onTapApply() {

    appController.setBoolValue(true, AppPrefsKeys.LANGUAGE_DIALOG);
    checkIfGoToSteps();
  }

  checkIfGoToSteps() {
    if (!(appController.getBoolValue(AppPrefsKeys.STEPS))) {
      getSteps();
      Get.to(() => StepsScreen());
    } else {
      if (appController.token.isNotEmpty) {
        Get.offAllNamed(AppRoutes.bottomNavBar);
      } else {
        Get.to(() => RolesScreen());
      }
    }
  }

  onPageChanged(int index) {
    pageIndex = index;
  }

  onTapRight() {
    if (pageIndex < steps.length - 1) {
      controller.animateToPage(pageIndex + 1,
          duration: const Duration(milliseconds: 250), curve: Curves.linear);
    } else {
      appController.setBoolValue(true, AppPrefsKeys.STEPS);

      Get.to(() => RolesScreen());
    }
  }

  onTapLeft() {
    if (pageIndex >= 1) {
      controller.animateToPage(pageIndex - 1,
          duration: const Duration(milliseconds: 250), curve: Curves.linear);
    }
  }

  getSteps() async {
    isLoadingSteps = true;
    GetStepsUseCase getStepsUseCase = sl();
    final result = await getStepsUseCase(());
    result!.fold((l) {
      isLoadingSteps = false;
    }, (r) {
      isLoadingSteps = false;
      steps = r.data ?? [];
    });
  }
}

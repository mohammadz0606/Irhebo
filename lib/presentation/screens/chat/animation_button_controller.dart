import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_controller.dart';

class AnimationButtonController extends GetxController
    with GetTickerProviderStateMixin {
  final chatController = Get.find<ChatController>();
  final RxBool _isMicAnimating = false.obs;
  late AnimationController micController;
  late AnimationController slideController;
  late Animation<double> slideAnimation;

  final RxBool _isSlideEnable = true.obs;
  final RxBool _isReverseSlideEnable = false.obs;

  bool get isSlideEnable => _isSlideEnable.value;

  bool get isReverseSlideEnable => _isReverseSlideEnable.value;

  set isSlideEnable(value) => _isSlideEnable.value = value;

  set isReverseSlideEnable(value) => _isReverseSlideEnable.value = value;

  String towDigits(int n) => n.toString().padLeft(2, '0');

  //Mic
  late Animation<double> micTranslateTop;
  late Animation<double> micRotationFirst;
  late Animation<double> micTranslateRight;
  late Animation<double> micTranslateLeft;
  late Animation<double> micRotationSecond;
  late Animation<double> micTranslateDown;
  late Animation<double> micInsideTrashTranslateDown;

  //Trash Can
  late Animation<double> trashWithCoverTranslateTop;
  late Animation<double> trashCoverRotationFirst;
  late Animation<double> trashCoverTranslateLeft;
  late Animation<double> trashCoverRotationSecond;
  late Animation<double> trashCoverTranslateRight;
  late Animation<double> trashWithCoverTranslateDown;

  bool get isMicAnimating => _isMicAnimating.value;

  set isMicAnimating(value) => _isMicAnimating.value = value;

  disposeAllControllers() {
    slideController.dispose();
    micController.dispose();
  }

  @override
  void onInit() {
    slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    slideAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(slideController);

    micController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    //Mic

    micTranslateTop = Tween(begin: 0.0, end: -150.0).animate(CurvedAnimation(
      parent: micController,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
    ));

    micRotationFirst = Tween(begin: 0.0, end: pi).animate(CurvedAnimation(
      parent: micController,
      curve: const Interval(0.0, 0.2),
    ));

    micTranslateRight = Tween(begin: 0.0, end: 13.0).animate(CurvedAnimation(
      parent: micController,
      curve: const Interval(0.0, 0.1),
    ));

    micTranslateLeft = Tween(begin: 0.0, end: -13.0).animate(CurvedAnimation(
      parent: micController,
      curve: const Interval(0.1, 0.2),
    ));

    micRotationSecond = Tween(begin: 0.0, end: pi).animate(CurvedAnimation(
      parent: micController,
      curve: const Interval(0.2, 0.45),
    ));

    micTranslateDown = Tween(begin: 0.0, end: 150.0).animate(CurvedAnimation(
      parent: micController,
      curve: const Interval(0.45, 0.79, curve: Curves.easeInOut),
    ));

    micInsideTrashTranslateDown =
        Tween(begin: 0.0, end: 55.0).animate(CurvedAnimation(
      parent: micController,
      curve: const Interval(0.95, 1.0, curve: Curves.easeInOut),
    ));

    //Trash Can

    trashWithCoverTranslateTop =
        Tween(begin: 30.0, end: -25.0).animate(CurvedAnimation(
      parent: micController,
      curve: const Interval(0.45, 0.6),
    ));

    trashCoverRotationFirst =
        Tween(begin: 0.0, end: -pi / 3).animate(CurvedAnimation(
      parent: micController,
      curve: const Interval(0.6, 0.7),
    ));

    trashCoverTranslateLeft =
        Tween(begin: 0.0, end: -18.0).animate(CurvedAnimation(
      parent: micController,
      curve: const Interval(0.6, 0.7),
    ));

    trashCoverRotationSecond =
        Tween(begin: 0.0, end: pi / 3).animate(CurvedAnimation(
      parent: micController,
      curve: const Interval(0.8, 0.9),
    ));

    trashCoverTranslateRight =
        Tween(begin: 0.0, end: 18.0).animate(CurvedAnimation(
      parent: micController,
      curve: const Interval(0.8, 0.9),
    ));

    trashWithCoverTranslateDown =
        Tween(begin: 0.0, end: 55.0).animate(CurvedAnimation(
      parent: micController,
      curve: const Interval(0.95, 1.0, curve: Curves.easeInOut),
    ));
    super.onInit();
  }
}

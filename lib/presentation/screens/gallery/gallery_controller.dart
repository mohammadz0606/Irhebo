// ignore_for_file: invalid_use_of_protected_member

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/domain/models/home_model.dart';

class GalleryController extends GetxController {
  ScrollController scrollController = ScrollController();
  PageController? pageController;

  final RxInt _pageIndex = 0.obs;

  int get pageIndex => _pageIndex.value;

  set pageIndex(value) => _pageIndex.value = value;

  List<MediaModel> mediaList = [];
  List<Uint8List> filesList = [];
  bool media = true;

  @override
  onInit() async {
    super.onInit();
    receiveParameters();
  }

  receiveParameters() {
    if (Get.arguments != null) {
      pageIndex = Get.arguments["index"] ?? 0;
      mediaList = Get.arguments["media_list"] ?? [];
      filesList = Get.arguments["files_list"] ?? [];
      media = mediaList.isNotEmpty;
    }
    pageController = PageController(initialPage: pageIndex);
  }

  onPageChanged(int index) {
    pageIndex = index;
  }

  onTapSliderImage(i) {
    pageIndex = i;
    pageController?.jumpToPage(i);
    _pageIndex.refresh();
    // scrollToSelected(i);
    // pageController!.animateToPage(pageIndex,
    //     duration: const Duration(microseconds: 50), curve: Curves.linear);
  }

  void scrollToSelected(int index) {
    double itemWidth = 10 * (Get.width / 100) + 10;
    double scrollOffset =
        (index * itemWidth) - (Get.width / 2) + (itemWidth / 2);
    scrollController.animateTo(
      scrollOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

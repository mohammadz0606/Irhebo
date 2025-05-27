import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:irhebo/presentation/screens/gallery/gallery_controller.dart';
import 'package:irhebo/presentation/screens/gallery/widgets/file_content.dart';
import 'package:irhebo/presentation/screens/gallery/widgets/files_bottom_slider.dart';
import 'package:irhebo/presentation/screens/gallery/widgets/gallery_bottom_slider.dart';
import 'package:irhebo/presentation/screens/gallery/widgets/gallery_content.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';

class GalleryScreen extends GetView<GalleryController> {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    // var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: NormalAppBar(title: controller.media ? "Gallery" : "Files"),
      body: Obx(
        () => controller.media
            ? Center(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GalleryContent(
                      media: controller.mediaList,
                      pageController: controller.pageController,
                      onPageChanged: controller.onPageChanged,
                    ),
                    GalleryBottomSlider(
                      media: controller.mediaList,
                      onTapSliderImage: (va) => controller.onTapSliderImage(va),
                      pageIndex: controller.pageIndex,
                      scrollController: controller.scrollController,
                    ),
                    SizedBox(
                      height: 10 * (w / 100),
                    )
                  ],
                ),
              )
            : Center(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FileContent(
                      files: controller.filesList,
                      pageController: controller.pageController,
                      onPageChanged: controller.onPageChanged,
                    ),
                    FilesBottomSlider(
                      files: controller.filesList,
                      onTapSliderImage: (va) => controller.onTapSliderImage(va),
                      pageIndex: controller.pageIndex,
                      scrollController: controller.scrollController,
                    ),
                    SizedBox(
                      height: 10 * (w / 100),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

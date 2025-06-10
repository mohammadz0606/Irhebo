import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/video_play_widget.dart';
import 'package:irhebo/presentation/screens/portfolio_details/portfolio_details_controller.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';

import '../../../../app/global_imports.dart';
import '../../../../app/resources/images.dart';
import '../../../../app/resources/style/colors.dart';
import '../../../../domain/providers/media.dart';
import '../../../widgets/app_icon.dart';

class PortfolioMedia extends GetWidget<PortfolioDetailsController> {
  const PortfolioMedia({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < controller.portfolio!.media!.length; i++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () => controller.onTapPortfolioMedia(i),
                    child: controller.portfolio!.media![i].mediaType != "image"
                        ? VideoMediaWidget(
                            mediaUrl:
                                controller.portfolio!.media![i].mediaPath ?? "")
                        : AppImage(
                            imageUrl:
                                controller.portfolio!.media![i].mediaPath ?? '',
                            height: 105 * (w / 100),
                            width: 100 * (w / 100),
                            radius: 8,
                          ),
                  ),
                  Positioned(
                      top: 10,
                      right: 10,
                      child: Consumer<MediaProvider>(
                        builder: (context, provider, _) {
                          return provider.isLoading
                              ? const CircularProgressIndicator.adaptive()
                              : GestureDetector(
                                  onTap: () async {
                                   await showAdaptiveDialog(
                                      context: Get.context!,
                                      barrierDismissible: false,
                                      builder: (_) {
                                        return AlertDialog.adaptive(
                                          title: Text('Delete Confirmation'.tr),
                                          content: Text(
                                            "Are you sure you want to delete this item?".tr,
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                Navigator.of(Get.context!).pop();
                                                await provider.deleteMedia(
                                                  id: controller.portfolio!.media![i].id ?? 0,
                                                  onSuccess: () async {
                                                    await controller.getPortfolioDetails();
                                                  },
                                                );

                                              },
                                              child: Text(
                                                "Yes".tr,
                                                style: const TextStyle(color: Colors.red),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(Get.context!).pop();
                                              },
                                              child: Text(
                                                "No".tr,
                                                style: const TextStyle(
                                                  color: AppLightColors.greenText,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );


                                  },
                                  child: const CircleAvatar(
                                    child: AppIcon(
                                      path: AppIcons.delete,
                                      color: AppDarkColors.pureWhite,
                                      height: 30,
                                      width: 20,
                                    ),
                                  ),
                                );
                        },
                      )),
                ],
              ),
              SizedBox(
                height: 4.97 * (w / 100),
              ),
            ],
          )
      ],
    );
  }
}

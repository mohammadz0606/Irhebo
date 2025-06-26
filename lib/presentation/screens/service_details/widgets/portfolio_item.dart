import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/domain/models/config_model.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/home_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/bottom_shadow_widget.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/video_play_widget.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';

import '../../../../app/global_imports.dart';
import '../../../../app/router/routes.dart';
import '../../../../domain/providers/freelancer/freelancer_portfolio.dart';
import '../../bottom_nav_bar/screens/home/widgets/freelancer/edit_or_delete.dart';

class PortfolioItem extends StatelessWidget {
  final bool freelancer;
  final Function() onTapItem;
  final DataModel portfoilo;

  const PortfolioItem({
    super.key,
    required this.portfoilo,
    this.freelancer = false,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => onTapItem(),
      child: Stack(
        children: [
          portfoilo.cover?.mediaType != "image"
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: VideoMediaWidget(
                      mediaUrl: portfoilo.cover?.mediaPath ?? ""),
                )
              : AppImage(
                  imageUrl: portfoilo.cover?.mediaPath ?? "",
                  width: freelancer ? 42 * (w / 100) : 39.3 * (w / 100),
                  height: freelancer ? 50.24 * (w / 100) : 50.24 * (w / 100),
                  radius: 25,
                ),
          Positioned(
            bottom: 0,
            child: BottomShadowWidget(
              width: freelancer ? 42 * (w / 100) : 39.3 * (w / 100),
              height: 15.92 * (w / 100),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(2.98 * (w / 100)),
                  child: Text(
                    portfoilo.title ?? "",
                    style: Get.theme.textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Get.find<AppController>().darkMode
                            ? null
                            : Colors.white),
                    maxLines: 2,
                  ),
                ),
              ),
            ),
          ),
          if (getUserRole == UserRoles.freelancer) ...{
            Positioned(
              top: 2.98 * (w / 100),
              right: 2.98 * (w / 100),
              child: EditOrDelete(
                space: 19,
                id: portfoilo.id ?? 0,
                onEditTap: () {
                  Get.toNamed(AppRoutes.createUpdatePortfolio, arguments: {
                    'data': portfoilo,
                    'id': portfoilo.id ?? 0,
                    'title': portfoilo.title,
                  });
                },
                onDeleteTap: () async {
                  showAdaptiveDialog(
                    context: Get.context!,
                    barrierDismissible: false,
                    builder: (_) {
                      return Consumer<FreelancerPortfolioProvider>(
                        builder: (context, provider, _) {
                          return AlertDialog.adaptive(
                            title: Text('Delete Confirmation'.tr),
                            content: Text(
                              "Are you sure you want to delete this item?".tr,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  await provider.deletePortfolio(
                                    onSuccess: () async {
                                      await provider.onRefreshList();
                                      if (getUserRole == UserRoles.client ||
                                          getUserRole == UserRoles.non) {
                                        await Get.find<HomeController>()
                                            .getHome();
                                        await Get.find<HomeController>()
                                            .getFeaturedPortfolio();
                                      } else {
                                        await Get.find<HomeController>()
                                            .getFreelancerHome();
                                      }
                                      log('DONE DELETE PORTFOLIO');
                                    },
                                    id: portfoilo.id ?? 0,
                                  );
                                  Navigator.of(Get.context!).pop();
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
                  );
                  // Get.defaultDialog(
                  //   title: 'Delete Confirmation'.tr,
                  //   middleText:
                  //       "Are you sure you want to delete this item?".tr,
                  //   textConfirm: "Yes".tr,
                  //   textCancel: "No".tr,
                  //   confirmTextColor: Colors.white,
                  //   buttonColor: Colors.red,
                  //   cancelTextColor: Colors.white,
                  //   onConfirm: () async {
                  //     await provider.deletePortfolio(
                  //       onSuccess: () {
                  //         controller.onRefreshList();
                  //         log('DONE DELETE PORTFOLIO');
                  //       },
                  //       id: data?.id ?? 0,
                  //     );
                  //     if (Get.isDialogOpen ?? false) {
                  //       Get.back();
                  //     }
                  //   },
                  //   onCancel: () {
                  //     if (Get.isDialogOpen ?? false) {
                  //       Get.back(); // يغلق الـ dialog فقط
                  //     }
                  //   },
                  // );
                },
              ),
            ),
          }
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/video_play_widget.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';

import '../../../../app/global_imports.dart';
import '../../../../app/resources/images.dart';
import '../../../../domain/providers/media.dart';
import '../../../widgets/app_icon.dart';
import '../service_details_controller.dart';

class MediaSection extends GetView<ServiceDetailsController> {
  final List<MediaModel> mediaList;
  final Function(int i)? onTapServices;

  const MediaSection({
    super.key,
    required this.mediaList,
    this.onTapServices,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < mediaList.length; i++)
                Stack(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => onTapServices!(i),
                          child: mediaList[i].mediaType != "image"
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: VideoMediaWidget(
                                      mediaUrl: mediaList[i].mediaPath ?? ""),
                                )
                              : AppImage(
                                  imageUrl: mediaList[i].mediaPath ?? "",
                                  width: 39.3 * (w / 100),
                                  height: 50.24 * (w / 100),
                                  radius: 25,
                                ),
                        ),
                        SizedBox(
                          width: 3.98 * (w / 100),
                        )
                      ],
                    ),
                    Positioned(
                        top: 10,
                        right: 24,
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
                                      title: Text(
                                          'Delete Confirmation'.tr),
                                      content: Text(
                                        "Are you sure you want to delete this item?"
                                            .tr,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            Navigator.of(Get.context!)
                                                .pop();
                                            await provider
                                                .deleteMedia(
                                              id: mediaList[i].id ??
                                                  0,
                                              onSuccess: () async {
                                                await controller
                                                    .getServiceDetails();
                                              },
                                            );
                                          },
                                          child: Text(
                                            "Yes".tr,
                                            style: const TextStyle(
                                                color: Colors.red),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(Get.context!)
                                                .pop();
                                          },
                                          child: Text(
                                            "No".tr,
                                            style: const TextStyle(
                                              color: AppLightColors
                                                  .greenText,
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
            ],
          ),
        ),
        SizedBox(
          height: 6.21 * (w / 100),
        ),
        const Divider(
          height: 1,
        )
      ],
    );
  }
}

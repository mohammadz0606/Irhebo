import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/domain/models/config_model.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/bottom_shadow_widget.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/video_play_widget.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';

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
          )
        ],
      ),
    );
  }
}

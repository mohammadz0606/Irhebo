import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/video_play_widget.dart';
import 'package:irhebo/presentation/screens/portfolio_details/portfolio_details_controller.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';

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
              SizedBox(
                height: 4.97 * (w / 100),
              ),
            ],
          )
      ],
    );
  }
}

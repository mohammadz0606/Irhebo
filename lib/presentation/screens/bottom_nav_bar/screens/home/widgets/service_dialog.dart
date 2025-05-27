import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/domain/models/config_model.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/video_play_widget.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';
import 'package:irhebo/presentation/widgets/freelancer_widget.dart';

class ServiceDialog extends StatelessWidget {
  const ServiceDialog({
    super.key,
    required this.portfolio,
    required this.onTapPortfolio,
    // required this.onTapFreelancer
  });
  final DataModel portfolio;
  final Function() onTapPortfolio;
  // final Function() onTapFreelancer;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
          top: 6.21 * (w / 100),
          right: 6.21 * (w / 100),
          left: 6.21 * (w / 100),
          bottom: 3.37 * (w / 100)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Text(serviceEntity?.id??""),
          SizedBox(
            height: 67.91 * (w / 100),
            child: portfolio.cover?.mediaType != "image"
                ? VideoMediaWidget(mediaUrl: portfolio.cover?.mediaPath ?? "")
                : AppImage(
                    imageUrl: portfolio.cover?.mediaPath ?? "",
                    height: 67.91 * (w / 100),
                    radius: 3.2 * (w / 100),
                  ),
          ),

          SizedBox(
            height: 3.37 * (w / 100),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => {
                  Get.back(),
                  Get.toNamed(AppRoutes.freelancerProfile,
                      arguments: {"id": portfolio.userId}),
                },
                child: FreelancerWidget(
                  forDialog: true,
                  home: false,
                  freelancerEntity: portfolio.user,
                ),
              ),
              AppButton(
                hieght: 8.95 * (w / 100),
                width: 25.37 * (w / 100),
                onPressed: () => onTapPortfolio(),
                title: "Details",
              )
            ],
          )
        ],
      ),
    );
  }
}

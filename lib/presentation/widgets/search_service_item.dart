// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';
import 'package:irhebo/presentation/widgets/like_widget.dart';
import 'package:irhebo/presentation/widgets/pricing_widget.dart';
import 'package:irhebo/presentation/widgets/rating_stars.dart';

class SearchServiceItem extends StatelessWidget {
  final bool isTherePadding;
  final ServiceModel service;
  final void Function() onLikeService;
  final void Function() onTapService;

  const SearchServiceItem({
    super.key,
    required this.service,
    required this.onLikeService,
    required this.onTapService,
    this.isTherePadding = true,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.99 * (w / 100)),
      child: Container(
        // height: 16.9*(w/100),
        padding: EdgeInsets.symmetric(
            vertical: 3.48 * (w / 100), horizontal: 3.98 * (w / 100)),
        width: 100 * (w / 100),
        decoration: AppDecoration.getDecorationWithRadius(
            radius: 20,
            color: Get.find<AppController>().darkMode
                ? AppDarkColors.darkContainer2
                : Colors.white),
        // decoration: Get.find<AppController>().darkMode
        //     ? AppDecoration.getDecorationWithRadius(
        //         radius: 20, color: AppDarkColors.darkContainer2)
        //     : AppDecoration.getDecorationWithShadow(radius: 20),
        child: Center(
          child: Row(
            children: [
              GestureDetector(
                onTap: () => onTapService(),
                child: AppImage(
                  imageUrl: service.cover ?? "",
                  width: 21.89 * (w / 100),
                  height: 22.38 * (w / 100),
                  radius: 15,
                ),
              ),
              SizedBox(
                width: 2.48 * (w / 100),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.title ?? "",
                      style: Get.theme.textTheme.labelLarge!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 0.64 * (w / 100),
                    ),
                    RatingStars(
                      count: service.rating ?? 0,
                    ),
                    SizedBox(
                      height: 0.64 * (w / 100),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PricingWidget(
                          number: service.startServiceFrom ?? "",
                          labelColor: Get.find<AppController>().darkMode
                              ? AppDarkColors.darkGreen
                              : AppLightColors.darkPrimary2,
                          numberColor: Get.find<AppController>().darkMode
                              ? AppDarkColors.green
                              : AppLightColors.primaryColor,
                        ),
                        LikeWidget(
                          color: Get.find<AppController>().darkMode
                              ? AppDarkColors.greenContainer
                              : AppLightColors.secondary,
                          liked: service.isWishlist ?? false,
                          onTap: () => onLikeService(),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

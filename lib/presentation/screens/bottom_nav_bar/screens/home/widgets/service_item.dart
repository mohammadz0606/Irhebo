// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';
import 'package:irhebo/presentation/widgets/freelancer_widget.dart';
import 'package:irhebo/presentation/widgets/like_widget.dart';
import 'package:irhebo/presentation/widgets/pricing_widget.dart';
import 'package:irhebo/presentation/widgets/rating_stars.dart';

class ServiceItem extends StatelessWidget {
  final ServiceModel? service;
  final void Function() onLikeService;
  final void Function() onTapService;
  final void Function() onTapFreelancer;
  final bool home;
  const ServiceItem({
    super.key,
    required this.service,
    required this.onLikeService,
    required this.onTapService,
    this.home = true,
    required this.onTapFreelancer,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: home ? 1.99 * (w / 100) : 0,
          vertical: home ? 2.48 * (w / 100) : 0),
      child: Container(
        decoration: Get.find<AppController>().darkMode
            ? null
            : AppDecoration.getDecorationWithShadow(radius: 18),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => onTapService(),
              child: AppImage(
                imageUrl: service?.cover ?? "",
                width: 57.46 * (w / 100),
                height: 63.38 * (w / 100),
                radius: 18,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 57.46 * (w / 100),
                height: 37.3 * (w / 100),
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: AppDecoration.getDecorationWithRadius(
                      color: Get.find<AppController>().darkMode
                          ? AppDarkColors.darkContainer2
                          : Colors.white,
                      radius: 18),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(2.48 * (w / 100)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service?.title ?? "",
                              style: Get.theme.textTheme.labelMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 1.74 * (w / 100),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RatingStars(
                                  count: service?.rating ?? 0,
                                ),
                                // RatingNumber(
                                //   number: (service?.rating ?? 0).toString(),
                                // ),
                                PricingWidget(
                                  number: service?.startServiceFrom ?? "",
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: Get.find<AppController>().darkMode
                            ? AppDarkColors.pureWhite.withOpacity(0.2)
                            : Colors.black.withOpacity(0.2),
                      ),
                      Padding(
                          padding: EdgeInsets.all(2.48 * (w / 100)),
                          child: GestureDetector(
                            onTap: () => onTapFreelancer(),
                            child: FreelancerWidget(
                              freelancerEntity: service?.user,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 2.98 * (w / 100),
              right: 2.98 * (w / 100),
              child: LikeWidget(
                liked: service?.isWishlist ?? false,
                onTap: () => onLikeService(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

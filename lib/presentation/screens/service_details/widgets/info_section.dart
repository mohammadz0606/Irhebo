import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/text_style.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/presentation/widgets/decorated_icon.dart';
import 'package:irhebo/presentation/widgets/freelancer_widget.dart';
import 'package:irhebo/presentation/widgets/rating_stars.dart';

class InfoSection extends StatelessWidget {
  final ServiceModel? service;
  final int reviews;
  final Function() onTapFreelancer;
  final Function() onLikeService;
  final Function() onTapChat;
  const InfoSection({
    super.key,
    required this.service,
    required this.onTapFreelancer,
    required this.reviews,
    required this.onLikeService,
    required this.onTapChat,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => onTapFreelancer(),
              child: FreelancerWidget(
                home: false,
                freelancerEntity: service?.user,
              ),
            ),
            Row(
              children: [
                GestureDetector(
                    // onTap: () => Get.toNamed(AppRoutes.chat,
                    //     arguments: {"chat_type": ChatType.Users}),
                    child: DecoratedIcon(
                  padding: 2.23 * (w / 100),
                  imagePath: AppIcons.link,
                  width: 9.95 * (w / 100),
                  height: 9.95 * (w / 100),
                )),
                SizedBox(
                  width: 3 * (w / 100),
                ),
                GestureDetector(
                    onTap: () => onTapChat(),
                    child: DecoratedIcon(
                      padding: 2.23 * (w / 100),
                      imagePath: AppIcons.message,
                      width: 9.95 * (w / 100),
                      height: 9.95 * (w / 100),
                    )),
                SizedBox(
                  width: 3 * (w / 100),
                ),
                GestureDetector(
                  onTap: () => onLikeService(),
                  child: DecoratedIcon(
                    width: 9.95 * (w / 100),
                    height: 9.95 * (w / 100),
                    padding: 2.23 * (w / 100),
                    color: Get.find<AppController>().darkMode
                        ? AppDarkColors.darkGreen.withOpacity(0.31)
                        : AppLightColors.secondary,
                    // ignore: dead_code
                    imagePath: service?.isWishlist == true
                        ? AppIcons.heart
                        : AppIcons.emptyHeart,
                    svgColor: Get.find<AppController>().darkMode
                        ? AppDarkColors.darkGreen
                        : AppLightColors.secondary,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 4.47 * (w / 100),
        ),
        Text(
          service?.title ?? "",
          style: Get.theme.textTheme.labelLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 1.49 * (w / 100),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RatingStars(
                  count: service?.rating ?? 0,
                ),
                // RatingNumber(
                //   number: (service?.rating).toString(),
                //   small: false,
                // ),
                SizedBox(
                  height: 2 * (w / 100),
                ),
                Text(
                  "$reviews ${"reviews".tr}",
                  style: Get.theme.textTheme.labelMedium!.copyWith(
                      color: Get.find<AppController>().darkMode
                          ? AppDarkColors.pureWhite.withOpacity(0.5)
                          : Colors.black.withOpacity(0.5),
                      decoration: TextDecoration.underline),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  service?.startServiceFrom ?? "",
                  style: Get.theme.textTheme.displaySmall!.copyWith(
                    fontSize: AppTextStyle.size20,
                  ),
                ),
                SizedBox(
                  height: 1 * (w / 100),
                ),
                Text(
                  "Start".tr,
                  style: Get.theme.textTheme.displaySmall!.copyWith(
                      fontSize: AppTextStyle.size17,
                      fontWeight: FontWeight.w500,
                      color: AppDarkColors.darkPrimary.withOpacity(0.7)),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 1.49 * (w / 100),
        ),
      ],
    );
  }
}

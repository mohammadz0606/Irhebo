import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/domain/models/service_details_model.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';
import 'package:irhebo/presentation/widgets/rating_stars.dart';

class ReviewItem extends StatelessWidget {
  final bool freelancer;
  final ReviewModel? review;
  final Function() onTapFreelancer;

  const ReviewItem({
    super.key,
    required this.review,
    this.freelancer = false,
    required this.onTapFreelancer,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => onTapFreelancer(),
              child: AppImage(
                imageUrl: review?.user?.avatar ?? "",
                width: 9.95 * (w / 100),
                height: 9.95 * (w / 100),
                radius: 50 * (w / 100),
              ),
            ),
            SizedBox(
              width: 1.99 * (w / 100),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        review?.user?.username ?? "",
                        style: Get.theme.textTheme.labelLarge!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        review?.createdAt ?? "",
                        style: Get.theme.textTheme.labelSmall!.copyWith(
                            color: Get.find<AppController>().darkMode
                                ? AppDarkColors.pureWhite.withOpacity(0.5)
                                : Colors.black.withOpacity(0.5)),
                      ),
                    ],
                  ),
                  RatingStars(
                    count: review?.rating ?? 0,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 1.99 * (w / 100),
        ),
        Text(
          review?.comment ?? "",
          style: Get.theme.textTheme.bodySmall!.copyWith(
              color: Get.find<AppController>().darkMode
                  ? Colors.white
                  : Colors.black),
        ),
        SizedBox(
          height: 2.98 * (w / 100),
        ),
        // if (freelancer)
        Divider(
          height: 1,
        )
      ],
    );
  }
}

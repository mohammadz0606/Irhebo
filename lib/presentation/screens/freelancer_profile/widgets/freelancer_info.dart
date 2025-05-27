import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/domain/models/freelancer_details_model.dart';
import 'package:irhebo/presentation/widgets/rating_stars.dart';

class FreelancerInfo extends StatelessWidget {
  final FreelancerModel? freelancer;
  final String rating;
  const FreelancerInfo(
      {super.key, required this.freelancer, required this.rating});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: 12.9 * (w / 100),
        ),
        Text(
          freelancer?.name ?? "",
          style: Get.theme.textTheme.labelLarge,
        ),
        Text(
          freelancer?.profession ?? "profession",
          style: Get.theme.textTheme.bodySmall,
        ),
        SizedBox(
          height: 1.74 * (w / 100),
        ),
        RatingStars(count: int.tryParse(rating) ?? 0),
        // RatingNumber(number: "4.5/5"),
        SizedBox(
          height: 3.98 * (w / 100),
        ),
      ],
    );
  }
}

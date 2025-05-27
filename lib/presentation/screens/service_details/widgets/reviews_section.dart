import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/domain/models/service_details_model.dart';
import 'package:irhebo/presentation/screens/service_details/widgets/review_item.dart';
import 'package:irhebo/presentation/widgets/app_title_with_action.dart';

class ReviewsSection extends StatelessWidget {
  final bool isThereShowMore;
  final bool freelancer;
  final List<ReviewModel> reviews;
  final Function()? onTapShowMore;
  final Function(int i) onTapFreelancer;
  const ReviewsSection({
    super.key,
    this.freelancer = false,
    required this.reviews,
    this.onTapShowMore,
    this.isThereShowMore = false,
    required this.onTapFreelancer,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(children: [
      if (!freelancer) AppTitleWithAction(title: "Reviews", services: true),
      SizedBox(
        height: 2.48 * (w / 100),
      ),
      for (int i = 0; i < reviews.length; i++)
        Column(
          children: [
            if (i != 0)
              SizedBox(
                height: 2.98 * (w / 100),
              ),
            ReviewItem(
              review: reviews[i],
              freelancer: freelancer,
              onTapFreelancer: () => onTapFreelancer(i),
            ),
          ],
        ),
      if (!freelancer && isThereShowMore)
        Row(
          children: [
            InkWell(onTap: () => onTapShowMore!(), child: Text("see more".tr)),
          ],
        )
    ]);
  }
}

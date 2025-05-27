import 'package:flutter/material.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/freelancer_item_shimmer.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

class ReviewItemShimmer extends StatelessWidget {
  const ReviewItemShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        for (int i = 0; i < 4; i++)
          Column(
            children: [
              if (i != 0)
                SizedBox(
                  height: 2.98 * (w / 100),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FreelancerItemShimmer(
                    isReview: true,
                  ),
                  SizedBox(
                    height: 1.99 * (w / 100),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < 3; i++)
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 1 * (w / 100)),
                          child: AppLoading(
                            height: 3 * (w / 100),
                            width: i == 0
                                ? 90 * (w / 100)
                                : i == 1
                                    ? 85 * (w / 100)
                                    : 70 * (w / 100),
                            radius: 5,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 2.98 * (w / 100),
                  ),
                  // if (freelancer)
                  Divider(
                    height: 1,
                  )
                ],
              )
            ],
          ),
      ],
    );
  }
}

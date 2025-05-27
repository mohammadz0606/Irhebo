// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

class FreelancerItemShimmer extends StatelessWidget {
  final bool isReview;
  const FreelancerItemShimmer({
    super.key,
    this.isReview = false,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: isReview
          ? EdgeInsets.symmetric(vertical: 1 * (w / 100))
          : EdgeInsets.all(4.48 * (w / 100)),
      child: Row(
        children: [
          AppLoading(
            width: 9.95 * (w / 100),
            height: 9.95 * (w / 100),
            radius: 50 * (w / 100),
          ),
          SizedBox(
            width: 1.49 * (w / 100),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppLoading(
                height: 3 * (w / 100),
                width: 30.16 * (w / 100),
                radius: 5,
              ),
              SizedBox(
                height: 1.99 * (w / 100),
              ),
              AppLoading(
                height: 3 * (w / 100),
                width: 30.16 * (w / 100),
                radius: 5,
              ),
            ],
          )
        ],
      ),
    );
  }
}

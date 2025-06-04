import 'package:flutter/material.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';

class FreelancerBackground extends StatelessWidget {
  const FreelancerBackground({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        AppIcon(
          path: AppImages.pattern,
          width: 100 * (w / 100),
          height: 63.68 * (w / 100),
          isSvg: false,
        ),
        SizedBox(
          height: 36.32 * (w / 100),
          width: 100.2 * (w / 100),
        )
      ],
    );
  }
}

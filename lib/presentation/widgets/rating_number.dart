// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';

class RatingNumber extends StatelessWidget {
  final String number;
  final bool small;
  const RatingNumber({
    super.key,
    required this.number,
    this.small = true,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AppIcon(
          path: AppIcons.star,
          height: 5.47 * (w / 100),
          width: 5.47 * (w / 100),
        ),
        SizedBox(
          width: 1.24 * (w / 100),
        ),
        Text(number,
            style: small
                ? Get.theme.textTheme.labelMedium
                : Get.theme.textTheme.labelLarge!.copyWith(
                    color: AppDarkColors.pureWhite.withOpacity(0.5),
                  ))
      ],
    );
  }
}

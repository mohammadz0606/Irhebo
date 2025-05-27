// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/resources/style/colors.dart';

class PricingWidget extends StatelessWidget {
  final String number;
  final Color? labelColor;
  final Color? numberColor;
  const PricingWidget({
    super.key,
    required this.number,
    this.labelColor,
    this.numberColor,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Text(
          "From".tr,
          style: Get.theme.textTheme.labelMedium!.copyWith(
              color: labelColor ?? AppDarkColors.pureWhite.withOpacity(0.5)),
        ),
        SizedBox(
          width: 1.24 * (w / 100),
        ),
        Text(
          number,
          style: Get.theme.textTheme.labelMedium!
              .copyWith(color: numberColor ?? Colors.white),
        )
      ],
    );
  }
}

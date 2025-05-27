import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

class DropDownShimmer extends StatelessWidget {
  final String? label;
  const DropDownShimmer({
    super.key,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label?.tr ?? "",
          style: Get.theme.textTheme.labelLarge!
              .copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 2.48 * (w / 100),
        ),
        AppLoading(
          height: 12.43 * (w / 100),
          width: w,
          radius: 14,
        ),
      ],
    );
  }
}

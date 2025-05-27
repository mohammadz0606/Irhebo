import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:readmore/readmore.dart';

class DescriptionSection extends StatelessWidget {
  final String? desciption;

  const DescriptionSection({
    super.key,
    required this.desciption,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 4.97 * (w / 100),
        ),
        Text(
          "Description".tr,
          style: Get.theme.textTheme.labelLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),

        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.23 * (w / 100)),
          child: ReadMoreText(
            desciption ?? "",
            trimMode: TrimMode.Line,
            style: Get.theme.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500),
            trimLines: 3,
            // colorClickableText: AppColors.pureWhite.withOpacity(0.75),
            trimCollapsedText: 'Show more'.tr,
            trimExpandedText: 'Show less'.tr,
            moreStyle: Get.theme.textTheme.labelLarge!.copyWith(
                color: AppDarkColors.pureWhite.withOpacity(0.75),
                decoration: TextDecoration.underline),
            lessStyle: Get.theme.textTheme.labelLarge!.copyWith(
                color: AppDarkColors.pureWhite.withOpacity(0.75),
                decoration: TextDecoration.underline),
          ),
        ),
        // Text(
        //   "Read More",
        //   style: Get.theme.textTheme.labelLarge!.copyWith(
        //       color: AppColors.pureWhite.withOpacity(0.75),
        //       decoration: TextDecoration.underline),
        // )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/domain/models/quotation_model.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';

class QuotationWidget extends StatelessWidget {
  final QuotationModel quotation;

  const QuotationWidget({
    super.key,
    required this.quotation,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      decoration: AppDecoration.getDecorationWithRadius(
          color: Get.find<AppController>().darkMode
              ? AppDarkColors.darkContainer2
              : AppLightColors.pureWhite,
          radius: 12),
      margin: EdgeInsets.symmetric(vertical: 1.99 * (w / 100)),
      padding: EdgeInsets.symmetric(
          horizontal: 4.49 * (w / 100), vertical: 3.48 * (w / 100)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            quotation.title ?? "",
            style: Get.theme.textTheme.labelLarge!
                .copyWith(fontWeight: FontWeight.w700),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            quotation.description ?? "",
            style: Get.theme.textTheme.labelMedium!
                .copyWith(fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 5.97 * (w / 100),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  AppImage(
                    imageUrl: quotation.user?.avatar ?? "",
                    width: 7.46 * (w / 100),
                    height: 7.46 * (w / 100),
                    radius: 25,
                  ),
                  SizedBox(
                    width: 2.73 * (w / 100),
                  ),
                  Text(
                    quotation.user?.username ?? "",
                    style: Get.theme.textTheme.labelMedium!
                        .copyWith(fontWeight: FontWeight.w700),
                    // maxLines: 1,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Text(
                quotation.createdAt ?? "",
                style: Get.theme.textTheme.labelMedium!
                    .copyWith(fontWeight: FontWeight.w700),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          )
        ],
      ),
    );
  }
}

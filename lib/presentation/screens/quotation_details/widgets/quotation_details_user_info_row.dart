import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/domain/models/quotation_model.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';

class QuotationDetailsUserInfoRow extends StatelessWidget {
  final QuotationModel quotation;
  const QuotationDetailsUserInfoRow({super.key, required this.quotation});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            AppImage(
              imageUrl: quotation.user?.avatar ?? "",
              width: 7.46 * (w / 100),
              height: 7.46 * (w / 100),
              radius: 50 * (w / 100),
            ),
            SizedBox(
              width: 3 * (w / 100),
            ),
            Text(quotation.user?.username ?? "",
                style: Get.theme.textTheme.labelMedium),
          ],
        ),
        Text(
          quotation.createdAt ?? "",
          style: Get.theme.textTheme.labelMedium,
        )
      ],
    );
  }
}

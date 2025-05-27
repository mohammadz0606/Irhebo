import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceRow extends StatelessWidget {
  final String title;
  final String price;
  final bool discount;
  final bool total;
  const PriceRow({
    super.key,
    required this.title,
    required this.price,
    this.discount = false,
    this.total = false,
  });

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title.tr,
          style: total
              ? Get.theme.textTheme.labelLarge!
                  .copyWith(fontWeight: FontWeight.w700)
              : Get.theme.textTheme.labelMedium,
        ),
        Text(
          price,
          style: total
              ? Get.theme.textTheme.labelLarge!
                  .copyWith(fontWeight: FontWeight.w700)
              : Get.theme.textTheme.labelMedium,
        )
      ],
    );
  }
}

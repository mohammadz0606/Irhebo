import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';

class QuotationAttributeRow extends StatelessWidget {
  const QuotationAttributeRow(
      {super.key, required this.title, this.value, this.withCheckBox = false});
  final String title;
  final String? value;
  final bool withCheckBox;

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(title.tr,
                style: Get.theme.textTheme.bodySmall!.copyWith(
                    color: Get.find<AppController>().darkMode
                        ? Colors.white
                        : Colors.black)),
          ],
        ),
        if (value != null)
          Text(
            value?.tr ?? "",
            style: Get.theme.textTheme.bodySmall!.copyWith(
                color: Get.find<AppController>().darkMode
                    ? Colors.white
                    : Colors.black),
          ),
      ],
    );
  }
}

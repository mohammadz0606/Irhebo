import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketDetailsRow extends StatelessWidget {
  final String title;
  final String subtitle;
  const TicketDetailsRow({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.99 * (w / 100)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.tr,
            style: Get.theme.textTheme.labelSmall!
                .copyWith(fontWeight: FontWeight.w700),
          ),
          Text(
            subtitle,
            style: Get.theme.textTheme.labelSmall!
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/resources/style/colors.dart';

class RequestStatusWidget extends StatelessWidget {
  final String status;

  const RequestStatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 2.73 * (w / 100),
        vertical: 0.49 * (w / 100),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppDarkColors.statusColor[status]?.withOpacity(0.2)),
      child: Text(
        status.tr,
        style: Get.theme.textTheme.labelMedium!
            .copyWith(color: AppDarkColors.statusColor[status]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';

class PasswordSpecifications extends StatelessWidget {
  final String condition;
  final Color color;
  const PasswordSpecifications(
      {super.key, required this.condition, required this.color});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.49 * (w / 100)),
      child: Row(
        children: [
          AppIcon(
            path: AppIcons.checkCircle,
            color: color,
          ),
          SizedBox(
            width: 0.99 * (w / 100),
          ),
          Text(
            condition.tr,
            style: Get.theme.textTheme.labelSmall!
                .copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

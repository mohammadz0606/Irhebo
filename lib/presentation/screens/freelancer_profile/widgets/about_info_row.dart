import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/widgets/decorated_icon.dart';

class AboutInfoRow extends StatelessWidget {
  final String icon;
  final String info;
  const AboutInfoRow({super.key, required this.icon, required this.info});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.48 * (w / 100)),
      child: Row(
        children: [
          DecoratedIcon(
            width: 7.46 * (w / 100),
            height: 7.46 * (w / 100),
            padding: 1.24 * (w / 100),
            imagePath: icon,
            svgColor: AppDarkColors.primaryColor,
            color: AppDarkColors.darkPrimary3.withOpacity(0.1),
          ),
          SizedBox(
            width: 2.48 * (w / 100),
          ),
          Text(info.tr, style: Get.theme.textTheme.labelLarge),
        ],
      ),
    );
  }
}

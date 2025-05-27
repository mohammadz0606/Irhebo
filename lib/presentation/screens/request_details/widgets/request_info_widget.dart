import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/resources/style/colors.dart';

class RequestInfoWidget extends StatelessWidget {
  const RequestInfoWidget({super.key, required this.title, this.count});

  final String title;
  final String? count;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3 * (w / 100)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title,
                style: Get.theme.textTheme.labelLarge,
              ),
            ],
          ),

          (count != null)
              ? Text(
                  count.toString(),
                  textAlign: TextAlign.center,
                  style: Get.theme.textTheme.labelLarge,
                )
              : Icon(
                  Icons.check_sharp,
                  color: AppDarkColors.primaryColor,
                )

          // if (isChecked != null && isChecked == false)
          //   Icon(
          //     Icons.close,
          //     color: AppColors.darkGreen,
          //   )
        ],
      ),
    );
  }
}

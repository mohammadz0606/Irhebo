import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBackButton extends StatelessWidget {
  final Function? onTap;

  const AppBackButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
          // color: AppColors.greyText,
          size: 5.5 * (w / 100),
        ),
        onPressed: () => Get.back());
  }
}

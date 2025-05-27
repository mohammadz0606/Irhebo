import 'package:flutter/material.dart';
import 'package:irhebo/app/resources/style/colors.dart';

class AppPlaceHolder extends StatelessWidget {
  final double widthOfImage;
  final double heightOfImage;

  const AppPlaceHolder(
      {super.key, required this.widthOfImage, required this.heightOfImage});

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        width: widthOfImage,
        height: heightOfImage,
        color: Colors.white,
        child: Center(
          child: SizedBox(
            width: widthOfImage / 4,
            height: widthOfImage / 4,
            child: const CircularProgressIndicator(
              color: AppDarkColors.primaryColor,
              strokeWidth: 1,
            ),
          ),
        ),
      ),
    );
  }
}

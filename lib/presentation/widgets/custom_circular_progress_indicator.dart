import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:irhebo/app/resources/style/colors.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Container(
        color: Colors.black.withOpacity(0.2),
        child: Align(
            alignment: Alignment.center,
            child: Center(
              child: SizedBox(
                width: 100 * (w / 100),
                height: 100 * (h / 100),
                child: Center(
                  child: SizedBox(
                    width: 15 * (w / 100),
                    height: 15 * (w / 100),
                    child: const CircularProgressIndicator(
                      color: AppDarkColors.primaryColor,
                      strokeWidth: 1,
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

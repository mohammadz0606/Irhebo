import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final Widget child;
  const BackgroundImage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Stack(
        children: [
          SizedBox(
            width: 100 * (w / 100),
            height: 100 * (h / 100),
            // color: Colors.white,
          ),
          // Positioned(
          //     bottom: 0,
          //     child: AppIcon(
          //       height: 53.7*(h/100),
          //       width: 100*(w/100),
          //       isSvg: false,
          //       path: AppImages.background,
          //       fit: BoxFit.contain,
          //     )),
          child
        ],
      ),
    );
  }
}

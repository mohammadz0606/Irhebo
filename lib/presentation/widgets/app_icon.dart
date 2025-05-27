// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcon extends StatelessWidget {
  final String path;
  final bool isSvg;
  final double? width;
  final double? height;
  final Color? color;
  final EdgeInsets? padding;
  final BoxFit? fit;
  final bool matchTextDirection;
  const AppIcon(
      {super.key,
      required this.path,
      this.color,
      this.isSvg = true,
      this.width,
      this.height,
      this.fit,
      this.padding,
      this.matchTextDirection = false});

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return Container(
        padding: padding,
        width: width,
        height: height,
        child: isSvg
            ? SvgPicture.asset(
                path,
                fit: fit ?? BoxFit.contain,
                color: color,
                matchTextDirection: matchTextDirection,
              )
            : Image.asset(path, fit: fit ?? BoxFit.cover));
  }
}

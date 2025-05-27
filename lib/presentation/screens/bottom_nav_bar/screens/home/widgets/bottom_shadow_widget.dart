// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';

class BottomShadowWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  const BottomShadowWidget({
    super.key,
    this.width,
    this.height,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18)),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff212121).withOpacity(0.0),
                Color(0xff212121).withOpacity(
                    Get.find<AppController>().darkMode ? 0.9 : 0.7),
              ])),
      height: height ?? 11.69 * (w / 100),
      width: width ?? 44.27 * (w / 100),
      child: child,
    );
  }
}

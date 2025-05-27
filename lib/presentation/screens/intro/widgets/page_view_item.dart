// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/domain/models/slider_model.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';

class PageViewItem extends StatelessWidget {
  final SliderModel step;
  const PageViewItem({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.3 * (w / 100)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppImage(
            imageUrl: step.mediaPath ?? "",
            width: 71.39 * (w / 100),
            height: 71.39 * (w / 100),
            radius: 40,
          ),
          SizedBox(
            height: 7.71 * (w / 100),
          ),
          SizedBox(
            width: 71.39 * (w / 100),
            child: Text(
              step.title ?? "",
              style: Get.theme.textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 3.73 * (w / 100),
          ),
          SizedBox(
            width: 71.39 * (w / 100),
            child: Text(
              step.description ?? "",
              style: Get.theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

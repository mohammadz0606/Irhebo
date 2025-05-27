// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/domain/models/slider_model.dart';
import 'package:irhebo/presentation/screens/intro/splash_controller.dart';
import 'package:irhebo/presentation/screens/intro/widgets/page_view_item.dart';

class StepsPageView extends GetWidget<SplashController> {
  final List<SliderModel> steps;
  const StepsPageView({
    super.key,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return Expanded(
      child: PageView(
        // allowImplicitScrolling: false,
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.controller,
        onPageChanged: controller.onPageChanged,
        children: [
          for (int i = 0; i < steps.length; i++)
            PageViewItem(
              step: steps[i],
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/presentation/screens/portfolio_details/portfolio_details_controller.dart';
import 'package:irhebo/presentation/screens/portfolio_details/widgets/portfolio_details_shimmer.dart';
import 'package:irhebo/presentation/screens/portfolio_details/widgets/portfolio_media.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';

class PortfolioDetailsScreen extends GetView<PortfolioDetailsController> {
  const PortfolioDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: NormalAppBar(
        title: controller.title,
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(5.97 * (w / 100)),
            child: controller.isLoading
                ? const PortfolioDetailsShimmer()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.portfolio?.title ?? '',
                        style: Get.theme.textTheme.bodySmall!.copyWith(
                            color: Get.find<AppController>().darkMode
                                ? Colors.white
                                : Colors.black),
                      ),
                      SizedBox(
                        height: 3 * (w / 100),
                      ),
                      const PortfolioMedia()
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/home_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/service_item_shimmer.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/service_item.dart';
import 'package:irhebo/presentation/widgets/app_title_with_action.dart';
import 'package:irhebo/presentation/widgets/no_data.dart';

class ServicesSection extends GetWidget<HomeController> {
  const ServicesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTitleWithAction(
          title: "Recommended",
        ),
        Obx(
          () => controller.isLoading
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 1.99 * (w / 100),
                      ),
                      for (int i = 0; i < 5; i++) ServiceItemShimmer()
                    ],
                  ),
                )
              : controller.services.isEmpty
                  ? NoData()
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 1.99 * (w / 100),
                          ),
                          for (int i = 0; i < controller.services.length; i++)
                            ServiceItem(
                              onTapFreelancer: () =>
                                  controller.onTapFreelancer(i),
                              onTapService: () => controller.onTapService(i),
                              service: controller.services[i],
                              onLikeService: () => controller.onLikeService(i),
                            )
                        ],
                      ),
                    ),
        ),
      ],
    );
  }
}

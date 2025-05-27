// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/home_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/category_item.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/category_item_shimmer.dart';
import 'package:irhebo/presentation/widgets/app_title_with_action.dart';

class CategoriesSection extends GetWidget<HomeController> {
  const CategoriesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTitleWithAction(
          title: "Popular Categories",
          action: "See All",
          onTapAction: () => Get.toNamed(AppRoutes.search),
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
                      for (int i = 0; i < 5; i++) CategoryItemShimmer()
                    ],
                  ),
                )
              : SizedBox(
                  width: w,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 1.99 * (w / 100),
                        ),
                        for (int i = 0; i < controller.categories.length; i++)
                          GestureDetector(
                            onTap: () => controller.onTapCategory(i),
                            child: CategoryItem(
                              category: controller.categories[i],
                            ),
                          )
                      ],
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

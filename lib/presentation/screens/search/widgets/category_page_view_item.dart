// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/category_item.dart';
import 'package:irhebo/presentation/screens/search/search_controller.dart'
    as sr;
import 'package:irhebo/presentation/screens/search/widgets/search_category_shimmer.dart';
// import 'package:irhebo/presentation/screens/intro/steps/steps_controller.dart' as sr;

class CategoryPageViewItem extends GetWidget<sr.SearchController> {
  const CategoryPageViewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Obx(
      () => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.97 * (w / 100)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppTitleWithAction(title: "Popular Services"),
              controller.isLoadingCategory
                  ? SearchCategoryShimmer()
                  : Wrap(
                      runSpacing: 11.9 * (w / 100),
                      spacing: 7.46 * (w / 100),
                      children: [
                        for (int i = 0; i < controller.categories.length; i++)
                          GestureDetector(
                            onTap: () => controller.onTapCategory(i),
                            child: CategoryItem(
                              category: controller.categories[i],
                              homeCategory: false,
                            ),
                          )
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}

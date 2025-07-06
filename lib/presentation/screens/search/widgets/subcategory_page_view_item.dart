// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/search/search_controller.dart'
    as sr;
import 'package:irhebo/presentation/screens/search/widgets/search_subcategory_shimmer.dart';
import 'package:irhebo/presentation/screens/search/widgets/subcategory_item.dart';

class SubCategoryPageViewItem extends GetWidget<sr.SearchControllerGetx> {
  const SubCategoryPageViewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          children: [
            // AppTitleWithAction(title: "Select Sub Category"),
            controller.isLoadingSubcategory
                ? const SearchSubcategoryShimmer()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.98 * (w / 100)),
                    child: Column(
                      children: [
                        for (int i = 0;
                            i < controller.subcategories.length;
                            i++)
                          GestureDetector(
                            onTap: () => controller.onTapSubCategory(i,pageIndex: 3),
                            child: SubcategoryItem(
                              subcategory: controller.subcategories[i],
                            ),
                          )
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

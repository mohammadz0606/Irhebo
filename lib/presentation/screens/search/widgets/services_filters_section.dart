// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/search/search_controller.dart'
    as sr;
import 'package:irhebo/presentation/screens/search/widgets/tag_item.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

class ServicesFiltersSection extends GetWidget<sr.SearchController> {
  const ServicesFiltersSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Obx(
      () => Column(
        children: [
          controller.isLoadingTag
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 4.47 * (w / 100),
                      ),
                      for (int i = 0; i < 6; i++)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.49 * (w / 100)),
                          child: AppLoading(
                            width: 18.15 * (w / 100),
                            height: 9.2 * (w / 100),
                            radius: 50 * (w / 100),
                          ),
                        )
                    ],
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 4.47 * (w / 100),
                      ),
                      for (int i = 0; i < controller.tags.length; i++)
                        TagItem(
                          title: controller.tags[i].title ?? "",
                          onTapTag: () => controller.onTapTag(i),
                          selected: controller.selectedType == i,
                        )
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

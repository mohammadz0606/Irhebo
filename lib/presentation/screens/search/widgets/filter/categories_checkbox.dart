import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/presentation/screens/search/widgets/filter/category_item_checkbox_widget.dart';
import 'package:irhebo/presentation/screens/search/search_controller.dart'
    as sr;

class CategoriesCheckbox extends GetWidget<sr.SearchControllerGetx> {
  final List<FilterModel> filters;
  const CategoriesCheckbox({
    super.key,
    required this.filters,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(("Category"),
        //     style: Get.theme.textTheme.titleMedium!.copyWith(
        //       fontWeight: FontWeight.w700,
        //       color: AppDarkColors.pureWhite,
        //     )),
        SizedBox(
          height: 2.48 * (w / 100),
        ),
        for (int i = 0; i < filters.length; i++)
          Column(
            children: [
              Obx(
                () => CategoryItemCheckboxWidget(
                    filter: filters[i],
                    onTap: (val) => controller.onPressCheckbox(i, val)),
              ),
              SizedBox(
                height: 2.4 * (w / 100),
              )
            ],
          ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.48 * (w / 100)),
          child: Divider(),
        ),
      ],
    );
  }
}

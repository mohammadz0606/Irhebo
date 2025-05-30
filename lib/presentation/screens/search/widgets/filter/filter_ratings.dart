import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/presentation/screens/search/widgets/filter/filter_rate_widget.dart';
import 'package:irhebo/presentation/screens/search/search_controller.dart'
    as sr;

class FilterRatings extends GetWidget<sr.SearchControllerGetx> {
  final List<FilterModel> filters;

  const FilterRatings({
    super.key,
    required this.filters,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < filters.length; i++)
          Column(
            children: [
              Text(filters[i].title ?? "",
                  style: Get.theme.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Get.find<AppController>().darkMode
                        ? AppDarkColors.pureWhite
                        : Colors.black,
                  )),
              SizedBox(
                height: 2.48 * (w / 100),
              ),
              Obx(
                () => FilterRateWidget(
                  onChange: (rate) => controller.onRate(rate, i),
                  currentRate: filters[i].rateValue ?? 0,
                ),
              ),
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

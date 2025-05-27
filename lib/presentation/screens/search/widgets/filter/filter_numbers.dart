import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/presentation/widgets/app_text_field.dart';

class FilterNumbers extends StatelessWidget {
  final List<FilterModel> filters;
  final List<TextEditingController> controllers;

  const FilterNumbers(
      {super.key, required this.filters, required this.controllers});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: w,
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceEvenly,
            spacing: 2.48 * (w / 100),
            runSpacing: 2.48 * (w / 100),
            // alignment: WrapAlignment.,
            children: [
              for (int i = 0; i < controllers.length; i++)
                SizedBox(
                  width: 26 * (w / 100),
                  child: AppTextField(
                    controller: controllers[i],
                    labelStyle: Get.theme.textTheme.labelMedium!
                        .copyWith(fontWeight: FontWeight.w700),
                    label: filters[i].title,
                    isNumber: true,
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.48 * (w / 100)),
          child: Divider(
            height: 1,
          ),
        ),
      ],
    );
  }
}

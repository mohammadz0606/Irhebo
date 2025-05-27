// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/presentation/widgets/dropdown_item.dart';
import 'package:irhebo/presentation/widgets/dropdown_widget.dart';

class FilterDropdownButtons extends StatelessWidget {
  final List<FilterModel> filters;
  final Map<int, FilterOptionModel?> selectedDropdownItems;
  final void Function(FilterOptionModel?, int) onChange;

  const FilterDropdownButtons({
    super.key,
    required this.filters,
    required this.onChange,
    required this.selectedDropdownItems,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Container(
      width: w,
      child: Column(
        children: [
          Column(
            children: [
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: filters.map((filter) {
                    return CustomDropdown<FilterOptionModel>(
                      itemBuilder: (context, item, isDisabled, isSelected) =>
                          DropdownItem(
                        label: item.title ?? "",
                      ),
                      label: filter.title ?? "Select".tr,
                      hintText: selectedDropdownItems[filter.id] != null
                          ? selectedDropdownItems[filter.id]!.title ?? ""
                          : "${"Select".tr} ${filter.title}",
                      items: filter.options ?? [],
                      onChanged: (value) {
                        onChange(value, filter.id!);
                      },
                      itemToString: (value) => value?.title ?? "",
                    );
                  }).toList(),
                ),
              ),
              if (filters.length > 1)
                SizedBox(
                  height: 2.48 * (w / 100),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.48 * (w / 100)),
            child: Divider(),
          ),
        ],
      ),
    );
  }
}

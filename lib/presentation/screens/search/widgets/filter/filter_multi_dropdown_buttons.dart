import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/presentation/widgets/multi_dropdown_widget.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class FilterMultiDropdownButtons extends StatelessWidget {
  final List<FilterModel> filters;
  final Map<int, List<FilterOptionModel?>> selectedItems;
  final void Function(List<FilterOptionModel?>, int) onConfirm;

  const FilterMultiDropdownButtons({
    super.key,
    required this.filters,
    required this.selectedItems,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    // List<FilterModel> dropdownFilters =
    //     filters.where((filter) => filter.type == "dropdown_multiple").toList();

    return Container(
      width: w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var filter in filters) ...[
            Obx(
              () => MultiCustomDropdown<FilterOptionModel>(
                items: filter.options!
                    .map((option) => MultiSelectItem<FilterOptionModel>(
                        option, option.title ?? ""))
                    .toList(),
                buttonText: selectedItems[filter.id]?.isNotEmpty == true
                    ? selectedItems[filter.id]![0]?.title ?? ""
                    : "${"Select".tr}  ${filter.title}",
                label: filter.title ?? "Select".tr,
                onConfirm: (values) {
                  onConfirm(values.cast<FilterOptionModel>(), filter.id!);
                },
                // onConfirm: (values) {
                //   selectedItems[filter.id!] = values.cast<FilterOptionModel>();
                // },
              ),
            ),
            if (filters.length > 1) SizedBox(height: 2.48 * (w / 100)),
          ],
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.48 * (w / 100)),
            child: Divider(),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/domain/providers/currency.dart';
import 'package:irhebo/presentation/screens/search/search_controller.dart'
    as sr;
import 'package:irhebo/presentation/screens/search/widgets/filter/categories_checkbox.dart';
import 'package:irhebo/presentation/screens/search/widgets/filter/filter_dropdown_buttons.dart';
import 'package:irhebo/presentation/screens/search/widgets/filter/filter_multi_dropdown_buttons.dart';
import 'package:irhebo/presentation/screens/search/widgets/filter/filter_numbers.dart';
import 'package:irhebo/presentation/screens/search/widgets/filter/filter_ratings.dart';
import 'package:irhebo/presentation/screens/search/widgets/filter/reange_slider.dart';
import 'package:irhebo/presentation/screens/search/widgets/filter/slider_control_widget.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/app_text_field.dart';
import 'package:irhebo/presentation/widgets/bottom_sheet_header.dart';

import '../../../../../app/global_imports.dart';
import '../../../../../app/injection.dart';
import '../../../../../app/storage/app_prefs.dart';
import '../../../../../app/storage/app_prefs_keys.dart';

class FilterBottomSheet extends GetView<sr.SearchControllerGetx> {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5.97 * (w / 100),
        vertical: 3.98 * (w / 100),
      ),
      child: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BottomSheetHeader(
              title: "Filter",
            ),

            /// edit
            Text(
              'Search'.tr,
              style: Get.textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            AppTextField(
              hint: 'Search here',
              controller: controller.searchFilterController,
            ),
            const SizedBox(height: 20),
            Consumer<CurrencyProvider>(
              builder: (context, provider, child) {
                return RangeSliderControlWidget(
                  minValue: 1,
                  maxValue: 1000,
                  title: 'Price',
                  initialStart: 1,
                  initialEnd: 1000,
                  rangeText: Get.locale?.languageCode == 'ar'
                      ? provider.getCurrentCurrency?.symbolAr ?? ''
                      : provider.getCurrentCurrency?.symbolEn ?? '',
                  onChangeRange: controller.onChangePriceRange,
                );
              },
            ),
            const SizedBox(height: 20),

            RangeSliderControlWidget(
              minValue: 1,
              maxValue: 10,
              title: 'Revisions',
              initialStart: 1,
              initialEnd: 10,
              rangeText: 'Times',
              onChangeRange: controller.onChangeRevisionsRange,
            ),
            const SizedBox(height: 20),
            RangeSliderControlWidget(
              minValue: 1,
              maxValue: 180,
              title: 'Delivery Day',
              initialStart: 1,
              initialEnd: 180,
              rangeText: 'Days',
              onChangeRange: controller.onChangeDeliveryDayRange,
            ),
            const SizedBox(height: 20),
            Obx(
              () => CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Source file'.tr,
                  style: Get.theme.textTheme.bodyMedium,
                ),
                dense: true,
                value: controller.sourceFile.value,
                onChanged: controller.onChangeSourceFile,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  onPressed: controller.resetFilter,
                  title: "Reset",
                  width: 40.29 * (w / 100),
                  hieght: 12 * (w / 100),
                  titlStyle: Get.theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Get.find<AppController>().darkMode
                          ? null
                          : AppLightColors.primaryColor),
                  backGroundColor: Get.find<AppController>().darkMode
                      ? AppDarkColors.darkContainer
                      : Colors.white,
                  borderColor: AppDarkColors.primaryColor,
                ),
                Obx(
                  () => AppButton(
                    onPressed: () async{
                      Navigator.pop(context);
                      await controller.applyFilter();
                    },
                    isLoading: controller.isLoadingService,
                    title: "Apply Filter",
                    width: 40.29 * (w / 100),
                    hieght: 12 * (w / 100),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2 * (w / 100),
            ),
          ],
        ),
      ),
    );
  }
}
/*
  if (controller.checkboxFilters.isNotEmpty)
              CategoriesCheckbox(
                filters: controller.checkboxFilters,
              ),
            if (controller.dropDownButtonsFilters.isNotEmpty)
              FilterDropdownButtons(
                filters: controller.dropDownButtonsFilters,
                selectedDropdownItems: controller.selectedDropdownItems,
                onChange: (value, id) => controller.onDropdownChange(id, value),
              ),
            if (controller.multiDropDownButtonsFilters.isNotEmpty)
              FilterMultiDropdownButtons(
                filters: controller.multiDropDownButtonsFilters,
                selectedItems: controller.selectedMultiDropdownItems,
                onConfirm: (values, id) =>
                    controller.onConfirmDropdown(values, id),
              ),
            // BudgetSlider(),
           if (controller.ratingFilters.isNotEmpty)
              FilterRatings(
                filters: controller.ratingFilters,
              ),
            if (controller.numbersFilters.isNotEmpty)
              FilterNumbers(
                controllers: controller.numbers,
                filters: controller.numbersFilters,
              ),
            SizedBox(
              height: 5 * (w / 100),
            ),
 */

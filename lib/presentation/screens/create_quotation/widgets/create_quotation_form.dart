import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/validators.dart';
import 'package:irhebo/presentation/screens/create_quotation/create_quotation_controller.dart';
import 'package:irhebo/presentation/widgets/app_text_field.dart';

import '../../../../app/global_imports.dart';
import '../../../../app/resources/images.dart';
import '../../../../domain/models/home_model.dart';
import '../../../../domain/models/new_models/currency_model.dart';
import '../../../../domain/providers/currency.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/dropdown_item.dart';
import '../../../widgets/dropdown_widget.dart';
import '../../search/search_controller.dart';

class CreateQuotationForm extends GetWidget<CreateQuotationController> {
  const CreateQuotationForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: 4.97 * (w / 100), horizontal: 5.72 * (w / 100)),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () {
                  return Column(
                    children: [
                      CustomDropdown<CategoryModel?>(
                        itemBuilder: (context, item, isDisabled, isSelected) =>
                            DropdownItem(
                          label: item?.title ?? "",
                        ),
                        showSearchBox: true,
                        label: "Categories",
                        hintText: "Category Choices",
                        items: Get.find<SearchControllerGetx>().categories,
                        onChanged: controller.onChangeCategory,
                        value: controller.categoryModel.value,
                        itemToString: (value) => value?.title ?? "",
                      ),
                      SizedBox(height: 2.98 * (w / 100)),

                      // Subcategories
                      if (controller.categoryModel.value != null)
                        Get.find<SearchControllerGetx>().isLoadingSubcategory
                            ? const Center(
                                child: CircularProgressIndicator.adaptive())
                            : CustomDropdown<SubcategoryModel?>(
                                itemBuilder:
                                    (context, item, isDisabled, isSelected) =>
                                        DropdownItem(
                                  label: item?.title ?? "",
                                ),
                                showSearchBox: true,
                                label: "Sub Categories",
                                hintText: "Category Choices",
                                items: Get.find<SearchControllerGetx>()
                                    .subcategories
                                    .toList(),
                                onChanged: controller.onChangeSubcategory,
                                value: controller.subcategoryModel.value,
                                itemToString: (value) => value?.title ?? "",
                              ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 2.98 * (w / 100),
              ),
              AppTextField(
                controller: controller.titleController,
                label: 'Title',
                hint: 'Enter request title',
                onValidate: AppValidators.validateField,
              ),
              SizedBox(
                height: 2.98 * (w / 100),
              ),
              AppTextField(
                controller: controller.descriptionController,
                label: 'Description',
                hint: 'Enter your username',
                onValidate: AppValidators.validateField,
                maxLines: 3,
              ),
              SizedBox(
                height: 2.98 * (w / 100),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 10,
                children: [
                  Expanded(
                    flex: 1,
                    child: AppTextField(
                      controller: controller.priceController,
                      label: 'Price',
                      hint: 'Enter price',
                      textInputType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [digitsAmountOnly],
                      onValidate: AppValidators.validateField,
                    ),
                  ),
                  Consumer<CurrencyProvider>(
                    builder: (context, currencyProvider, child) {
                      return Expanded(
                        child: _buildCurrencyDropDown(
                          w,
                          currencyProvider,
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 2.98 * (w / 100),
              ),
              AppTextField(
                controller: controller.deliveryDayController,
                //readOnly: true,
                label: 'Delivery Day',
                hint: 'Select delivery day',
                onValidate: AppValidators.validateField,
                textInputType: TextInputType.number,
                inputFormatters: [digitsOnly],
                //onTap: () => controller.openDateTimePicker(context),
                // suffixIcon: const Icon(
                //   Icons.calendar_month,
                //   color: AppDarkColors.green,
                // ),
              ),
              SizedBox(
                height: 2.98 * (w / 100),
              ),
              AppTextField(
                controller: controller.revisionsController,
                label: 'Revisions',
                hint: 'Enter number of revisions',
                textInputType: TextInputType.number,
                inputFormatters: [digitsOnly],
                onValidate: AppValidators.validateField,
              ),
              SizedBox(
                height: 2.98 * (w / 100),
              ),
              Row(
                children: [
                  Obx(() => SizedBox(
                        width: 4.97 * (w / 100),
                        height: 4.97 * (w / 100),
                        child: Checkbox(
                          activeColor: Get.find<AppController>().darkMode
                              ? AppDarkColors.greenContainer
                              : AppLightColors.secondary,
                          value: controller.checked,
                          onChanged: controller.onChangeCheck,
                        ),
                      )),
                  SizedBox(
                    width: 3 * (w / 100),
                  ),
                  Text(
                    'Source file'.tr,
                    style: Get.theme.textTheme.bodySmall!.copyWith(
                      color: Get.find<AppController>().darkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Container _buildCurrencyDropDown(
    double w,
    CurrencyProvider currencyProvider,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
      child: DropdownSearch<CurrencyModelData>(
        selectedItem: controller.selectedCurrency.value,
        onChanged: controller.onSelectedCurrency,
        validator: null,
        compareFn: (item1, item2) => item1.id == item2.id,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        popupProps: PopupPropsMultiSelection<CurrencyModelData>.menu(
          itemBuilder: (context, item, isDisabled, isSelected) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: Text(item.symbolEn ?? ''),
          ),
          fit: FlexFit.loose,
          menuProps: MenuProps(
            backgroundColor: Get.find<AppController>().darkMode
                ? AppDarkColors.darkScaffoldColor
                : AppLightColors.pureWhite,
            barrierColor: Get.find<AppController>().darkMode
                ? AppDarkColors.darkContainer.withOpacity(0.3)
                : AppLightColors.shadow.withOpacity(0.3),
          ),
          searchFieldProps: TextFieldProps(
            cursorColor: Get.find<AppController>().darkMode
                ? AppDarkColors.pureWhite.withOpacity(0.5)
                : Colors.black.withOpacity(0.5),
            decoration: InputDecoration(
              filled: true,
              fillColor: Get.find<AppController>().darkMode
                  ? AppDarkColors.darkContainer.withOpacity(0.5)
                  : AppLightColors.fillTextField,
              hintStyle: getRegularStyle(
                  color: Get.find<AppController>().darkMode
                      ? AppDarkColors.pureWhite.withOpacity(0.5)
                      : Colors.black.withOpacity(0.5),
                  fontSize: AppTextStyle.size14),
              enabledBorder: dropDownOutlinedBorder,
              border: dropDownOutlinedBorder,
              focusedBorder: dropDownOutlinedBorder,
              disabledBorder: dropDownOutlinedBorder,
              contentPadding: EdgeInsets.symmetric(
                vertical: 3.48 * (w / 100),
                horizontal: 4.97 * (w / 100),
              ),
            ),
          ),
          showSearchBox: true,
        ),
        itemAsString: (CurrencyModelData item) =>
            Get.locale?.languageCode == 'ar'
                ? item.symbolAr ?? ''
                : item.symbolEn ?? '',
        suffixProps: DropdownSuffixProps(
          dropdownButtonProps: DropdownButtonProps(
            splashRadius: 14,
            iconClosed: AppIcon(
              path: AppIcons.arrowbottom,
              color: Get.find<AppController>().darkMode
                  ? AppDarkColors.pureWhite.withOpacity(0.5)
                  : Colors.black.withOpacity(0.5),
            ),
            iconOpened: AppIcon(
              path: AppIcons.arrowbottom,
              color: Get.find<AppController>().darkMode
                  ? AppDarkColors.pureWhite.withOpacity(0.5)
                  : Colors.black.withOpacity(0.5),
            ),
          ),
        ),
        items: (filter, loadProps) async {
          return currencyProvider.currencyModel?.data ?? [];
        },
        decoratorProps: DropDownDecoratorProps(
          baseStyle: getRegularStyle(
            color: Get.find<AppController>().darkMode
                ? AppDarkColors.pureWhite.withOpacity(0.5)
                : Colors.black.withOpacity(0.5),
            fontSize: AppTextStyle.size16,
          ),
          decoration: InputDecoration(
            filled: true,
            enabled: true,
            fillColor: Get.find<AppController>().darkMode
                ? AppDarkColors.darkContainer.withOpacity(0.5)
                : AppLightColors.fillTextField,
            enabledBorder: dropDownOutlinedBorder,
            border: dropDownOutlinedBorder,
            focusedBorder: dropDownOutlinedBorder,
            disabledBorder: dropDownOutlinedBorder,
            contentPadding: EdgeInsets.symmetric(
              vertical: 3.48 * (w / 100),
              horizontal: 4.97 * (w / 100),
            ),
            hintText: 'Currency',
            hintStyle: getRegularStyle(
              color: Get.find<AppController>().darkMode
                  ? AppDarkColors.pureWhite.withOpacity(0.5)
                  : Colors.black.withOpacity(0.5),
              fontSize: AppTextStyle.size14,
            ),
          ),
        ),
      ),
    );
  }
}

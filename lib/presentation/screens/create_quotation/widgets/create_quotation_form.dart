import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/validators.dart';
import 'package:irhebo/presentation/screens/create_quotation/create_quotation_controller.dart';
import 'package:irhebo/presentation/widgets/app_text_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../domain/models/home_model.dart';
import '../../../widgets/dropdown_item.dart';
import '../../../widgets/dropdown_widget.dart';
import '../../../widgets/multi_dropdown_widget.dart';
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
              AppTextField(
                controller: controller.priceController,
                label: 'Price',
                hint: 'Enter price',
                textInputType: TextInputType.number,
                onValidate: AppValidators.validateField,
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
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
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
}

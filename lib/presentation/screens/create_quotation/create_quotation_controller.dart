import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/global_imports.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/domain/params/create_quotation_params.dart';
import 'package:irhebo/domain/usecases/setting_usecase/create_quotation_use_case.dart';

import '../../../domain/models/new_models/currency_model.dart';
import '../../../domain/providers/currency.dart';
import '../search/search_controller.dart';

class CreateQuotationController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController deliveryDayController = TextEditingController();
  TextEditingController revisionsController = TextEditingController();
  Rx<CategoryModel?> categoryModel = Rx<CategoryModel?>(null);
  Rx<CurrencyModelData?> selectedCurrency = Rx<CurrencyModelData?>(null);
  Rx<SubcategoryModel?> subcategoryModel = Rx<SubcategoryModel?>(null);

  final RxBool _isLoading = false.obs;
  final RxBool _checked = false.obs;

  bool get isLoading => _isLoading.value;

  bool get checked => _checked.value;

  set isLoading(value) => _isLoading.value = value;

  set checked(value) => _checked.value = value;

  DateTime? selectedDate;

  // String selectedDateValue

  onTapBack() {
    Get.back();
  }

  @override
  void onInit() {
    clearData();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<CurrencyProvider>(Get.context!, listen: false)
          .getCurrencies();
    });

    super.onInit();
  }

  createQuotation() async {
    if (formKey.currentState!.validate()) {
      if (categoryModel.value == null || subcategoryModel.value == null || selectedCurrency.value == null) {
        AppSnackBar.openErrorSnackBar(message: 'Please fill all fields'.tr);
        return;
      }

      isLoading = true;
      CreateQuotationUseCase createQuotationUseCase = sl();
      final result = await createQuotationUseCase(
        CreateQuotationParams(
          title: titleController.text,
          description: descriptionController.text,
          deliveryDay: int.tryParse(deliveryDayController.text),
          price: double.tryParse(priceController.text),
          revisions: int.tryParse(revisionsController.text),
          sourceFile: checked,
          subCategoryId: subcategoryModel.value?.id,
          currency: selectedCurrency.value?.symbolEn ?? 'USD',
        ),
      );
      result!.fold((l) {
        isLoading = false;
      }, (r) {
        onTapBack();
        AppSnackBar.openSuccessSnackBar(
            message: 'Quotation created successfully'.tr);
        isLoading = false;
      });
    }
  }

  clearData() {
    titleController.text = "";
    descriptionController.text = "";
    priceController.text = "";
    deliveryDayController.text = "";
    revisionsController.text = "";
    selectedDate = null;
    checked = false;
    categoryModel.value = null;
    subcategoryModel.value = null;
    selectedCurrency.value = null;
  }

  onChangeCheck(bool? value) {
    checked = value;
  }

  onSelectedCurrency(CurrencyModelData? value) {
    selectedCurrency.value = value;
  }

  onChangeCategory(CategoryModel? value) async {
    categoryModel.value = value;
    subcategoryModel.value = null;

    if (value != null) {
      await Get.find<SearchControllerGetx>().getSubcategories(value.id!);
      update();
    }
  }

  onChangeSubcategory(SubcategoryModel? value) {
    subcategoryModel.value = value;
  }

  Future<void> openDateTimePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: selectedDate ?? DateTime.now(),
      lastDate: DateTime(2026),
      barrierColor: AppDarkColors.darkContainer,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Get.theme,
          child: child!,
        );
      },
    );
    // deliveryDayController.text = date.toString();
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      selectedDate!.toUtc().toString().split(' ')[0];
      deliveryDayController.text =
          selectedDate!.toUtc().toString().split(' ')[0];
      log(deliveryDayController.text);
    }
  }
}

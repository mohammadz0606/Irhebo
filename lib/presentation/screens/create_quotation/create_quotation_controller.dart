import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/domain/params/create_quotation_params.dart';
import 'package:irhebo/domain/usecases/setting_usecase/create_quotation_use_case.dart';

class CreateQuotationController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController deliveryDayController = TextEditingController();
  TextEditingController revisionsController = TextEditingController();

  final RxBool _isLoading = false.obs;
  final RxBool _checked = false.obs;

  bool get isLoading => _isLoading.value;
  bool get checked => _checked.value;

  set isLoading(value) => _isLoading.value = value;
  set checked(value) => _checked.value = value;

  DateTime? selectedDate;
  // String selectedDateValue

  @override
  void onInit() {
    super.onInit();
  }

  onTapBack() {
    Get.back();
  }

  createQuotation() async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      CreateQuotationUseCase createQuotationUseCase = sl();
      final result = await createQuotationUseCase(CreateQuotationParams(
          title: titleController.text,
          description: descriptionController.text,
          deliveryDay: DateTime.parse(deliveryDayController.text)
              .difference(DateTime.now())
              .inDays,
          price: double.tryParse(priceController.text),
          revisions: int.tryParse(revisionsController.text),
          sourceFile: checked));
      result!.fold((l) {
        isLoading = false;
      }, (r) {
        clearData();
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
  }

  onChangeCheck(bool? value) {
    checked = value;
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

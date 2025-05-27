import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/presentation/screens/create_quotation/create_quotation_controller.dart';
import 'package:irhebo/presentation/screens/create_quotation/widgets/create_quotation_form.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';

class CreateQuotationScreen extends GetView<CreateQuotationController> {
  const CreateQuotationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.find<AppController>().darkMode ? null : Colors.white,
      appBar: NormalAppBar(
        title: 'Create Quotation',
        color: Get.find<AppController>().darkMode ? null : Colors.white,
      ),
      body: SingleChildScrollView(child: CreateQuotationForm()),
      bottomNavigationBar: Obx(
        () => AppButton(
          isLoading: controller.isLoading,
          bottom: true,
          onPressed: controller.createQuotation,
          title: 'Create Quotation',
        ),
      ),
    );
  }
}

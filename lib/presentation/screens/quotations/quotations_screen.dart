import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/quotations/quotations_controller.dart';
import 'package:irhebo/presentation/screens/quotations/widgets/quotations_list.dart';
import 'package:irhebo/presentation/widgets/add_button.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';

class QuotationsScreen extends GetView<QuotationsController> {
  const QuotationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const NormalAppBar(
        title: "Quotations",
      ),
      body: const QuotationsList(),
      floatingActionButton: AddButton(
        onTap: controller.createQuotation,
      ),
    );
  }
}

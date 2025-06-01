import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_functions.dart';
import 'package:irhebo/presentation/screens/quotations/quotations_controller.dart';
import 'package:irhebo/presentation/screens/quotations/widgets/quotations_list.dart';
import 'package:irhebo/presentation/widgets/add_button.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';

import '../../../app/enums.dart';

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
      floatingActionButton: getUserRole == UserRoles.freelancer
          ? null
          : AddButton(
              onTap: controller.createQuotation,
            ),
    );
  }
}

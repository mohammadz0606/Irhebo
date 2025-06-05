import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/quotation_details/quotation_details_controller.dart';
import 'package:irhebo/presentation/screens/quotation_details/widgets/quotation_details_widget.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';

class QuotationDetailsScreen extends GetView<QuotationDetailsController> {
  const QuotationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: NormalAppBar(
        title: controller.title,
        onTapBack: controller.onTapBack,
        // onTapHistory: () => Get.toNamed(AppRoutes.requestHistory),
      ),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(
              vertical: 7.21 * (w / 100), horizontal: 4.47 * (w / 100)),
          child: controller.isLoading
              ? AppLoading(
                  height: 101.24 * (w / 100),
                  width: w,
                  radius: 18,
                )
              : QuotationDetailsWidget(
                  quotation: controller.quotation!,
                ),
        ),
      ),
    );
  }
}

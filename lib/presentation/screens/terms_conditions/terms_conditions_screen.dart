import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/presentation/screens/terms_conditions/terms_conditions_controller.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';

class TermsConditionsScreen extends GetView<TermsConditionsController> {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: NormalAppBar(
        title: "Terms And Conditions",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 3.98 * (w / 100), horizontal: 5.97 * (w / 100)),
          child: Column(
            children: [
              HtmlWidget(
                controller.appController.generalData?.terms ?? "",
                textStyle: Get.theme.textTheme.bodyMedium!.copyWith(
                  color: Get.find<AppController>().darkMode
                      ? Colors.white.withOpacity(0.85)
                      : Colors.black.withOpacity(0.85),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

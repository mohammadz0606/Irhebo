import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/presentation/screens/privacy_policy/privacy_policy_controller.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';

class PrivacyPolicyScreen extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: NormalAppBar(
        title: "Privacy Policy",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 3.98 * (w / 100), horizontal: 5.97 * (w / 100)),
              child: Column(
                children: [
                  HtmlWidget(
                    controller.appController.generalData?.privacy ?? "",
                    textStyle: Get.theme.textTheme.bodyMedium!.copyWith(
                      color: Get.find<AppController>().darkMode
                          ? Colors.white.withOpacity(0.85)
                          : Colors.black.withOpacity(0.85),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

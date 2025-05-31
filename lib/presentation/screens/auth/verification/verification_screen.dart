import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/presentation/screens/auth/verification/widgets/pinput_widget.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/auth_app_bar.dart';
import 'package:irhebo/presentation/widgets/auth_headline.dart';
import 'package:irhebo/presentation/widgets/background_image.dart';

import 'verification_controller.dart';

class VerificationScreen extends GetView<VerificationController> {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return BackgroundImage(
      child: Scaffold(
        backgroundColor:
            Get.find<AppController>().darkMode ? null : Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(27 * (w / 100)),
          child: const AuthAppBar(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.97 * (w / 100)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthHeadline(
                  title: "Verify your phone number",
                  subtitle: "Enter your details to create your account",
                  bottomPadding: 12.18 * (w / 100),
                ),
                const PinPutWidget(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => AppButton(
            isLoading: controller.isLoadingVerify,
            bottom: true,
            onPressed: controller.onTapVerify,
            title: "Verify",
          ),
        ),
      ),
    );
  }
}

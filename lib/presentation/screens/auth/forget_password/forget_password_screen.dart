import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/validators.dart';
import 'package:irhebo/presentation/screens/auth/forget_password/forget_password_controller.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/app_text_field.dart';
import 'package:irhebo/presentation/widgets/auth_app_bar.dart';
import 'package:irhebo/presentation/widgets/auth_headline.dart';
import 'package:irhebo/presentation/widgets/background_image.dart';

class ForgetPasswordScreen extends GetView<ForgetPasswordController> {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return BackgroundImage(
      child: Scaffold(
        backgroundColor:
            Get.find<AppController>().darkMode ? null : Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(27 * (w / 100)),
            child: AuthAppBar()),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.97 * (w / 100)),
            child: Form(
              key: controller.forgetPasswordKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthHeadline(
                    title: "Verify your phone number",
                    subtitle: "Enter your phone number to reset password",
                    bottomPadding: 12.18 * (w / 100),
                  ),
                  AppTextField(
                    controller: controller.phoneConfirmation,
                    label: "Phone Number",
                    hint: "05***********",
                    initialSelection: controller.appController.countryCode,
                    isPhone: true,
                    onValidate: AppValidators.validatePhone,
                    onChangeCountryCode:
                        controller.appController.onChangeCountryCode,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Obx(() => AppButton(
              bottom: true,
              onPressed: controller.requestCode,
              isLoading: controller.isLoading,
              title: "Send Code",
            )),
      ),
    );
  }
}

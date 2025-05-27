import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/presentation/screens/auth/create_password/widgets/cretae_password_form.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/auth_app_bar.dart';
import 'package:irhebo/presentation/widgets/auth_headline.dart';
import 'package:irhebo/presentation/widgets/background_image.dart';

import 'create_password_controller.dart';

class CreatePasswordScreen extends GetView<CreatePasswordController> {
  const CreatePasswordScreen({super.key});

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.type == PasswordScreenType.reset_password)
                  AuthHeadline(
                    title: "Create a new Password",
                    subtitle:
                        "New password must be differnt from current password",
                    bottomPadding: 5.72 * (w / 100),
                  ),
                CretaePasswordForm(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => AppButton(
            bottom: true,
            isLoading: controller.isLoading,
            onPressed: controller.onTapSave,
            title: controller.type == PasswordScreenType.update_password
                ? "Update"
                : "Confirm",
          ),
        ),
      ),
    );
  }
}

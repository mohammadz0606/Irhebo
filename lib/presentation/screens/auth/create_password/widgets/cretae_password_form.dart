import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/constants.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/validators.dart';
import 'package:irhebo/presentation/screens/auth/create_password/create_password_controller.dart';
import 'package:irhebo/presentation/screens/auth/create_password/widgets/password_specifications.dart';
import 'package:irhebo/presentation/screens/auth/create_password/widgets/strengthen_password_widget.dart';
import 'package:irhebo/presentation/widgets/app_text_field.dart';

import '../../../../../app/app_regex.dart';

class CretaePasswordForm extends GetWidget<CreatePasswordController> {
  const CretaePasswordForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return GetBuilder<CreatePasswordController>(builder: (context) {
      return Form(
        key: controller.resetPasswordKey,
        child: Obx(
          () => Column(
            children: [
              if (controller.type == PasswordScreenType.update_password)
                Column(
                  children: [
                    AppTextField(
                      controller: controller.createCurrentPassword,
                      label: "Current Password",
                      hint: "Enter Password",
                      isPassword: true,
                      isVisible: controller.createIsVisibile,
                      onTapVisible: () => controller.onTapVisibile(),
                      onValidate: AppValidators.validatePassword,
                      textInputType: TextInputType.visiblePassword,
                      inputFormatters: [
                        englishOnlyFormatter
                      ],
                    ),
                    SizedBox(
                      height: 2.98 * (w / 100),
                    ),
                  ],
                ),
              AppTextField(
                  controller: controller.createPassword,
                  label: "New Password",
                  hint: "Enter Password",
                  isPassword: true,
                  isThereError: false,
                  textInputType: TextInputType.visiblePassword,
                  inputFormatters: [
                    englishOnlyFormatter
                  ],
                  isVisible: controller.createIsVisibile,
                  onTapVisible: () => controller.onTapVisibile(),
                  onValidate: AppValidators.validateNewPassword,
                  onChange: (password) =>
                      controller.checkPasswordStrength(password)),
              SizedBox(
                height: 2.98 * (w / 100),
              ),
              StrengthenPasswordWidget(
                score: controller.score.value,
              ),
              SizedBox(
                height: 2.98 * (w / 100),
              ),
              AppTextField(
                controller: controller.createRePassword,
                label: "Confirm New Password",
                hint: "ReEnter Password",
                isPassword: true,
                textInputType: TextInputType.visiblePassword,
                inputFormatters: [
                  englishOnlyFormatter
                ],
                isVisible: controller.createIsVisibile,
                onValidate: (confirmed) => AppValidators.validatePasswordConf(
                    confirmed, controller.createPassword.text),
                onTapVisible: () => controller.onTapVisibile(),
              ),
              SizedBox(
                height: 3.48 * (w / 100),
              ),
              Column(
                children: [
                  for (int i = 0;
                      i < AppConstants.passwordConditions.length;
                      i++)
                    PasswordSpecifications(
                      condition: AppConstants.passwordConditions[i],
                      color: i < controller.score.value
                          ? Get.find<AppController>().darkMode
                              ? AppDarkColors.greenContainer
                              : const Color.fromARGB(255, 48, 2, 133)
                          : Colors.grey[400]!,
                    ),
                ],
              ),
              SizedBox(
                height: 0.49 * (w / 100),
              ),
            ],
          ),
        ),
      );
    });
  }
}

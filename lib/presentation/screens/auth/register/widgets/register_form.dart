import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/constants.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/validators.dart';
import 'package:irhebo/presentation/screens/auth/create_password/widgets/password_specifications.dart';
import 'package:irhebo/presentation/screens/auth/create_password/widgets/strengthen_password_widget.dart';
import 'package:irhebo/presentation/screens/auth/register/register_controller.dart';
import 'package:irhebo/presentation/screens/auth/register/widgets/register_info_buttons.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/app_text_field.dart';

class RegisterForm extends GetWidget<RegisterController> {
  const RegisterForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Obx(
      () => Form(
        key: controller.signupKey,
        child: Column(
          children: [
            AppTextField(
              controller: controller.registerPhone,
              label: "Phone Number",
              hint: "05***********",
              initialSelection: controller.appController.countryCode,
              onChangeCountryCode: controller.appController.onChangeCountryCode,
              isPhone: true,
              onValidate: AppValidators.validatePhone,
            ),
            SizedBox(
              height: 2.98 * (w / 100),
            ),
            AppTextField(
              controller: controller.registerEmail,
              label: "Email",
              enabled: Get.arguments == null,
              hint: "Enter your email",
              textInputType: TextInputType.emailAddress,
              onValidate: AppValidators.validateEmail,
            ),
            SizedBox(
              height: 2.98 * (w / 100),
            ),
            AppTextField(
              controller: controller.registerUserName,
              label: "User Name",
              hint: "Enter your username",
              onValidate: AppValidators.validateName,
            ),
            RegisterInfoButtons(
              countries: controller.appController.countries,
              genders: controller.appController.genders,
              languages: controller.appController.languages,
              professions: controller.appController.professions,
              onChangedCountry: controller.onSelectCountry,
              onChangedGender: controller.onSelectGender,
              onChangedProfession: controller.onSelectProfession,
              onConfirmLanguages: controller.onConfirmLanguages,
              languagesHint: controller.selectedLanguages.length == 1
                  ? controller.selectedLanguages[0]?.title ?? ""
                  : controller.selectedLanguages.length >= 2
                      ? "${controller.selectedLanguages[0]?.title ?? ""} ${controller.selectedLanguages[1]?.title ?? ""}.."
                      : "Select Language".tr,
            ),
            if (Get.arguments == null) ...{
              AppTextField(
                  controller: controller.registerPassword,
                  label: "Password",
                  hint: "Enter Password",
                  onValidate: AppValidators.validateNewPassword,
                  isPassword: true,
                  isThereError: false,
                  isVisible: controller.registerIsVisibile,
                  onTapVisible: () => controller.onTapVisibile(),
                  onChange: (password) =>
                      controller.checkPasswordStrength(password)),
              SizedBox(
                height: 2.98 * (w / 100),
              ),
              StrengthenPasswordWidget(
                score: controller.score.value,
              ),
              SizedBox(
                height: 2.89 * (w / 100),
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
                height: 2.98 * (w / 100),
              ),
              AppTextField(
                controller: controller.registerConfirmPassword,
                label: "Confirm Password",
                hint: "ReEnter Password",
                isPassword: true,
                isVisible: controller.registerIsVisibile,
                onValidate: (confirmed) => AppValidators.validatePasswordConf(
                    confirmed, controller.registerPassword.text),
                onTapVisible: () => controller.onTapVisibile(),
              ),
            },
            SizedBox(
              height: 5.47 * (w / 100),
            ),
            AppButton(
              onPressed: controller.onTapSignUp,
              title: "Sign Up",
              isLoading: controller.isLoading,
            ),
          ],
        ),
      ),
    );
  }
}

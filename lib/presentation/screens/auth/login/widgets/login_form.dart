import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/global_imports.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/validators.dart';
import 'package:irhebo/presentation/screens/auth/login/login_controller.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/app_text_field.dart';

class LoginForm extends GetWidget<LoginController> {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Form(
      key: controller.loginFormKey,
      child: Column(
        children: [
          AppTextField(
            controller: controller.loginPhone,
            label: "Phone Number",
            hint: "05***********",
            isPhone: true,
            textInputType: TextInputType.phone,
            inputFormatters: [
              digitsOnly,
            ],
            initialSelection: controller.appController.countryCode,
            onValidate: AppValidators.validatePhone,
            onChangeCountryCode: controller.appController.onChangeCountryCode,
          ),
          SizedBox(
            height: 2.98 * (w / 100),
          ),
          Obx(
            () => AppTextField(
              controller: controller.loginPassword,
              label: "Password",
              hint: "Enter Password",
              isPassword: true,
              textInputType: TextInputType.visiblePassword,
              inputFormatters: [
                englishOnlyFormatter,
              ],
              isVisible: controller.isVisibileLogin,
              onValidate: AppValidators.validatePassword,
              onTapVisible: () => controller.onTapVisibile(),
            ),
          ),
          SizedBox(
            height: 1.64 * (w / 100),
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: InkWell(
              onTap: controller.onTapForgetPassword,
              child: Text("Forget Password".tr,
                  style: Get.theme.textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Get.find<AppController>().darkMode
                          ? AppDarkColors.pureWhite.withOpacity(0.5)
                          : Colors.black.withOpacity(0.5))),
            ),
          ),
          SizedBox(
            height: 5.47 * (w / 100),
          ),
          Obx(
            () => AppButton(
              onPressed: () => controller.loginClient(),
              title: "Login",
              isLoading: controller.isLoading,
            ),
          ),
        ],
      ),
    );
  }
}

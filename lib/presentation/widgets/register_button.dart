import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/router/routes.dart';

class RegisterButton extends StatelessWidget {
  final bool login;
  const RegisterButton({super.key, this.login = false});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.97 * (w / 100)),
        child: InkWell(
          onTap: () => login ? Get.toNamed(AppRoutes.register) : Get.back(),
          child: RichText(
            text: TextSpan(
              text: login
                  ? ("${"Dont have an account".tr} ")
                  : ("${"Already have account".tr} "),
              style: Get.theme.textTheme.labelLarge!
                  .copyWith(fontWeight: FontWeight.w400),
              children: [
                TextSpan(
                  text: login ? "Register Now".tr : "Login".tr,
                  style: Get.theme.textTheme.labelLarge!.copyWith(
                      color: Get.find<AppController>().darkMode
                          ? AppDarkColors.greenText
                          : AppLightColors.primaryColor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

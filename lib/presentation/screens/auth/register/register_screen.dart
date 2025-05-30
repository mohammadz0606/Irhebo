import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/presentation/screens/auth/register/register_controller.dart';
import 'package:irhebo/presentation/screens/auth/register/widgets/register_form.dart';
import 'package:irhebo/presentation/widgets/auth_app_bar.dart';
import 'package:irhebo/presentation/widgets/auth_headline.dart';
import 'package:irhebo/presentation/widgets/background_image.dart';
import 'package:irhebo/presentation/widgets/register_button.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return BackgroundImage(
      child: Scaffold(
        backgroundColor:
            Get.find<AppController>().darkMode ? null : Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(27 * (w / 100)),
            child: const AuthAppBar()),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 4.97 * (w / 100)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthHeadline(
                title: "Create an Account",
                subtitle: "Enter your details to create your account",
                bottomPadding: 8.95 * (w / 100),
              ),
              const RegisterForm(),
              const RegisterButton()
            ],
          ),
        ),
      ),
    );
  }
}

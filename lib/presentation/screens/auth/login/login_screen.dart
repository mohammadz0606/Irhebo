import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/presentation/screens/auth/login/widgets/login_form.dart';
import 'package:irhebo/presentation/screens/auth/login/widgets/social_section.dart';
import 'package:irhebo/presentation/widgets/auth_app_bar.dart';
import 'package:irhebo/presentation/widgets/auth_headline.dart';
import 'package:irhebo/presentation/widgets/background_image.dart';

import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

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
                AuthHeadline(
                  title: "Login to your account",
                  subtitle: "Enter your details to access your account",
                  bottomPadding: 8.95 * (w / 100),
                ),
                LoginForm(),
                SocialSection()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

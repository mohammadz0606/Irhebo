import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/presentation/screens/intro/splash_controller.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/auth_app_bar.dart';
import 'package:irhebo/presentation/widgets/auth_headline.dart';
import 'package:irhebo/presentation/widgets/language_item_widget.dart';

class LanguageScreen extends GetWidget<SplashController> {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Get.find<AppController>().darkMode ? null : Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(27 * (w / 100)),
          child: const AuthAppBar(
            hasBack: false,
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.97 * (w / 100)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AuthLogo(),
            const AuthHeadline(
              title: "Select Language",
              subtitle: "Choose your preference language",
            ),
            Directionality(
            textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < 2; i++)
                    Obx(
                      () => LanguageItemWidget(
                        onTap: () {
                          controller.onChangeLanguage(i);
                        },
                        selected: i == controller.selectedLangIndex,
                        title: i == 0 ? "English" : "العربية",
                        icon: i == 0 ? AppIcons.usa : AppIcons.ksa,
                        language: true,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppButton(
        bottom: true,
        onPressed: () => controller.onTapApply(),
        title: "Apply",
      ),
    );
  }
}

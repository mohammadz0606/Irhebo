import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/presentation/screens/auth/register/widgets/register_info_buttons.dart';
import 'package:irhebo/presentation/screens/profile/profile_controller.dart';

import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/app_text_field.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';

class UpdateProfileScreen extends GetWidget<ProfileController> {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Get.find<AppController>().darkMode ? null : Colors.white,
      appBar: NormalAppBar(
        title: "Update Profile",
        color: Get.find<AppController>().darkMode ? null : Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 4.97 * (w / 100), vertical: 4.6 * (w / 100)),
              child: Form(
                key: controller.updateProfileKey,
                child: Column(
                  children: [
                    AppTextField(
                      controller: controller.email,
                      label: "Email",
                      hint: "Enter your email",
                    ),
                    SizedBox(
                      height: 2.98 * (w / 100),
                    ),
                    AppTextField(
                      controller: controller.userName,
                      label: "User Name",
                      hint: "Enter your username",
                    ),
                    SizedBox(
                      height: 2.98 * (w / 100),
                    ),
                    AppTextField(
                      controller: controller.phone,
                      initialSelection: controller.appController.countryCode,
                      label: "Phone Number",
                      hint: "05***********",
                      isPhone: true,
                      enabled: false,
                    ),
                    Obx(
                      () => RegisterInfoButtons(
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
                        selectedLanguages: controller.selectedLanguages,
                        initCountry: controller.country,
                        initProfessions: controller.profession,
                        initGender: controller.gender,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => AppButton(
          isLoading: controller.isLoadingUpdate,
          bottom: true,
          onPressed: controller.updateProfileButton,
          title: "Save",
        ),
      ),
    );
  }
}

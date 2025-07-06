import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/presentation/screens/faqs/faqs_controller.dart';
import 'package:irhebo/presentation/screens/faqs/widgets/faqs_shimmer.dart';
import 'package:irhebo/presentation/screens/faqs/widgets/faqs_widget.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';

import '../../../app/enums.dart';

class FaqsScreen extends GetView<FaqsController> {
  final int? categoryId;
  const FaqsScreen({super.key, this.categoryId});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const NormalAppBar(
        title: "FAQ",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(vertical: 1 * (w / 100)),
                child: controller.isLoading
                    ? const FaqsShimmer()
                    : Column(
                        children: [
                          for (int i = 0; i < controller.faqs.length; i++)
                            Column(
                              children: [
                                FaqsWidget(
                                  faqs: controller.faqs[i],
                                  onTapClose: () => controller.onTapFaqs(i),
                                  isVisible: controller.faqs[i].visible,
                                  onTapOpen: () => controller.onTapFaqs(i),
                                ),
                                const Divider(
                                  height: 1,
                                )
                              ],
                            )
                        ],
                      ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: (controller.appController.token.isNotEmpty)
          ? AppButton(
              bottom: true,
              onPressed: () => Get.toNamed(AppRoutes.chat, arguments: {
                "chat_type": ChatType.Bot,
                'chat_bot_type': ChatBotType.faq,
              }),
              backGroundColor: Get.find<AppController>().darkMode
                  ? AppDarkColors.darkContainer
                  : AppLightColors.primaryColor,
              borderColor: Get.find<AppController>().darkMode
                  ? AppDarkColors.greenContainer
                  : null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Still need help".tr),
                  SizedBox(
                    width: 1 * (w / 100),
                  ),
                  AppIcon(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    path: AppIcons.customer,
                    color: Colors.white,
                    width: 5.47 * (w / 100),
                    height: 5.47 * (w / 100),
                  )
                ],
              ),
            )
          : null,
    );
  }
}

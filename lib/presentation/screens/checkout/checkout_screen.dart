import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'package:irhebo/presentation/screens/checkout/checkout_controller.dart';
import 'package:irhebo/presentation/screens/checkout/widgets/summary_widget.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';
import 'package:irhebo/presentation/widgets/app_title_with_action.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';

class CheckoutScreen extends GetView<CheckoutController> {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const NormalAppBar(
        title: "Checkout",
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.98 * (w / 100)),
            child: controller.isLoading
                ? AppLoading(
                    height: 47 * (w / 100),
                    width: 92 * (w / 100),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [

                      SizedBox(
                        height: 7.71 * (w / 100),
                      ),
                      Text(
                        controller.checkout?.title ?? "",
                        style: Get.theme.textTheme.labelLarge,
                      ),
                      SizedBox(
                        height: 2.73 * (w / 100),
                      ),
                      Text(
                        controller.checkout?.description ?? "",
                        style: Get.theme.textTheme.bodyMedium?.copyWith(
                            color: Get.find<AppController>().darkMode
                                ? AppDarkColors.pureWhite.withOpacity(0.4)
                                : Colors.black.withOpacity(0.4)),
                      ),

                      Container(
                        width: 100 * (w / 100),
                        margin: EdgeInsets.symmetric(
                          vertical: 3 * (w / 100),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 1.99 * (w / 100),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: AppDarkColors.primaryColor.withOpacity(0.2)),
                        child: Text(
                          controller.checkout?.planTitle ?? "",
                          textAlign: TextAlign.center,
                          style: Get.theme.textTheme.labelLarge
                              ?.copyWith(color: AppDarkColors.primaryColor),
                        ),
                      ),
                      //     SizedBox(
                      //       height: 4.47 * (w / 100),
                      //     ),
                      //     // PlanInfo(plan: ,),
                      //     SizedBox(
                      //       height: 7.96 * (w / 100),
                      //     ),
                      //   ],
                      // ),
                      const AppTitleWithAction(
                        title: "Summary",
                        services: true,
                      ),
                      SizedBox(
                        height: 2.48 * (w / 100),
                      ),
                      SummaryWidget(
                        model: controller.checkout!,
                      ),
                      SizedBox(
                        height: 30.96 * (w / 100),
                      ),
                    ],
                  ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () {
          return AppButton(
            isLoading: controller.isLoadingPlan,
            onPressed: () async {
              await controller.createRequest();
            },
            bottom: true,
            title: "Continue",
          );
        },
      ),
    );
  }
}

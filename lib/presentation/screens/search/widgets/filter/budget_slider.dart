import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/presentation/screens/search/search_controller.dart'
    as sr;

class BudgetSlider extends GetWidget<sr.SearchController> {
  const BudgetSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Budget".tr,
            style: Get.theme.textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.w700,
            )),
        Row(
          children: [
            Text(controller.selectedMin.toString(),
                style: Get.theme.textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                )),
            Obx(
              () => Expanded(
                child: RangeSlider(
                    values: RangeValues(
                      controller.selectedMin,
                      controller.selectedMax,
                    ),
                    min: controller.sliderRange.start,
                    max: controller.sliderRange.end,
                    // labels: RangeLabels(
                    //   "\$${controller.selectedMin.toStringAsFixed(0)}",
                    //   "\$${controller.selectedMax.toStringAsFixed(0)}",
                    // ),
                    overlayColor: WidgetStateProperty.all(
                        AppDarkColors.primaryColor.withOpacity(0.1)),
                    inactiveColor: Get.find<AppController>().darkMode
                        ? AppDarkColors.pureWhite.withOpacity(0.5)
                        : Colors.grey[300],
                    onChanged: controller.changeBudgetRange),
              ),
            ),
            Text(controller.selectedMax.toString(),
                style: Get.theme.textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                decoration: AppDecoration.getDecorationWithRadius(
                    color: Get.find<AppController>().darkMode
                        ? AppDarkColors.darkContainer2
                        : AppLightColors.fillTextField,
                    radius: 10),
                width: 25 * (w / 100),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  controller: controller.minSliderController,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(
                        RegExp(r'^0')), // Prevents starting with 0
                    FilteringTextInputFormatter
                        .digitsOnly // Allows only numbers
                  ],
                  onFieldSubmitted: (value) {
                    controller.onChangeMinField(double.tryParse(value));
                  },
                  style: Get.theme.textTheme.labelSmall?.copyWith(
                      color: Get.find<AppController>().darkMode
                          ? Colors.white
                          : Colors.black.withOpacity(0.5)),
                )),
            Container(
              decoration: AppDecoration.getDecorationWithRadius(
                  color: Get.find<AppController>().darkMode
                      ? AppDarkColors.darkContainer2
                      : AppLightColors.fillTextField,
                  radius: 10),
              child: SizedBox(
                  width: 25 * (w / 100),
                  child: TextFormField(
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(
                          RegExp(r'^0')), // Prevents starting with 0
                      FilteringTextInputFormatter
                          .digitsOnly // Allows only numbers
                    ],
                    controller: controller.maxSliderController,
                    onFieldSubmitted: (value) {
                      controller.onChangeMaxField(double.tryParse(value));

                      print(value);
                    },
                    style: Get.theme.textTheme.labelSmall?.copyWith(
                        color: Get.find<AppController>().darkMode
                            ? Colors.white
                            : Colors.black.withOpacity(0.5)),
                  )),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4 * (w / 100)),
          child: Divider(),
        ),
      ],
    );
  }
}

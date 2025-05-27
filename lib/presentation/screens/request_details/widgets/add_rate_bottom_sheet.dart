import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/resources/validators.dart';

import 'package:irhebo/presentation/screens/request_details/request_details_controller.dart';
import 'package:irhebo/presentation/screens/search/widgets/filter/filter_rate_widget.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/app_text_field.dart';

class AddRateBottomSheet extends GetWidget<RequestDetailsController> {
  const AddRateBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      // color: Colors.white,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(vertical: 6 * (w / 100)),
                child: FilterRateWidget(
                  onChange: (rate) => controller.onRate(rate),
                  currentRate: controller.currentRate,
                ),
              ),
            ),
            Form(
              key: controller.reviewKey,
              child: AppTextField(
                hint: "write your comment",
                maxLines: 4,
                controller: controller.reviewController,
                onValidate: AppValidators.validateReview,
              ),
            ),
            SizedBox(
              height: 10 * (w / 100),
            ),
            Obx(
              () => AppButton(
                isLoading: controller.isLoadingReview,
                onPressed: controller.submit,
                title: "Rate",
                // width: 30*(w/100),
              ),
            ),
            SizedBox(
              height: 4 * (w / 100),
            ),
          ]),
    );
  }
}

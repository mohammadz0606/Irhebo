import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/home_controller.dart';

import 'package:irhebo/presentation/widgets/app_button.dart';

class AddBottomSheet extends GetView<HomeController> {
  const AddBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      // width: w,
      padding: EdgeInsets.symmetric(
        horizontal: 11.94 * (w / 100),
        vertical: 8.7 * (w / 100),
      ),
      child: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppButton(
              onPressed: controller.onTapCreateSupportTicket,
              title: "Create support ticket",
            ),
            SizedBox(
              height: 4.97 * (w / 100),
            ),
            AppButton(
              onPressed: controller.onTapRequestForQuotation,
              title: "Request for quotation",
            ),
          ],
        ),
      ),
    );
  }
}

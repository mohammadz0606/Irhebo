import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as UserRole;
import 'package:irhebo/app/global_imports.dart';
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
          spacing:  4.97 * (w / 100),
          children: getUserRole == UserRole.Client ? [
            AppButton(
              onPressed: controller.onTapCreateSupportTicket,
              title: "Create support ticket",
              backGroundColor: AppLightColors.greenContainer,
            ),
            AppButton(
              onPressed: controller.onTapRequestForQuotation,
              title: "Request for quotation",
              backGroundColor: AppLightColors.greenContainer,
            ),
          ] : [
            AppButton(
              onPressed: () {},
              title: "Create Service",
              backGroundColor: AppLightColors.greenContainer,
            ),

            AppButton(
              onPressed: () {},
              title: "Add Portfolio",
              backGroundColor: AppLightColors.greenContainer,
            ),

            AppButton(
              onPressed: () {},
              title: "Create support ticket",
              backGroundColor: AppLightColors.greenContainer,
            ),
          ],
        ),
      ),
    );
  }
}

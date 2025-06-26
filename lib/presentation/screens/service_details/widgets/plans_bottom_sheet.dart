import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_functions.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/presentation/screens/search/widgets/tag_item.dart';
import 'package:irhebo/presentation/screens/service_details/service_details_controller.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/bottom_sheet_header.dart';
import 'package:irhebo/presentation/widgets/plan_info.dart';

class PlansBottomSheet extends GetWidget<ServiceDetailsController> {
  const PlansBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      constraints: BoxConstraints(
          minHeight: 100 * (w / 100), maxHeight: 140 * (w / 100)),
      padding: EdgeInsets.symmetric(
        horizontal: 5.97 * (w / 100),
        vertical: 3.98 * (w / 100),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BottomSheetHeader(
            title: "Plans",
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0;
                    i < controller.serviceDetails.plans!.length;
                    i++)
                  Obx(
                    () => SizedBox(
                     // width: 27.11 * (w / 100),
                      child: TagItem(
                        // freelancer: true,
                        selected: i == controller.selectedTab,
                        title: controller.serviceDetails.plans?[i].title ?? "",
                        onTapTag: () => controller.onChangeTab(i),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 4.47 * (w / 100),
          ),
          Obx(
            () => Expanded(
                child: SingleChildScrollView(
              child: PlanInfo(
                plan: controller.serviceDetails.plans![controller.selectedTab],
              ),
            )),
          ),
          if(getUserRole != UserRoles.freelancer)
          Padding(
            padding: EdgeInsets.only(top: 3 * (w / 100)),
            child: Obx(
              () => AppButton(
                isLoading: controller.isLoadingPlan,
                onPressed:
                    controller.isLoadingPlan ? () {} : controller.selectPlan,
                title: "Select",
              ),
            ),
          )
        ],
      ),
    );
  }
}

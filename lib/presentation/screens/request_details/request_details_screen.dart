import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/request_details/request_details_controller.dart';
import 'package:irhebo/presentation/screens/request_details/widgets/request_bottom_buttons_shimmer.dart';
import 'package:irhebo/presentation/screens/request_details/widgets/request_details_bottom_bar.dart';
import 'package:irhebo/presentation/screens/request_details/widgets/request_details_brief.dart';
import 'package:irhebo/presentation/screens/request_details/widgets/request_details_shimmer.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';
import 'package:irhebo/presentation/widgets/plan_info.dart';

class RequestDetailsScreen extends GetView<RequestDetailsController> {
  const RequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Obx(
      () => Scaffold(
        appBar: NormalAppBar(
          title: controller.title.isEmpty
              ? (controller.isLoading
                  ? 'Loading'.tr
                  : controller.request.title ?? '')
              : controller.title,
          onTapBack: controller.onTapBack,
          onTapHistory: controller.request.statusKey == 'pending'
              ? null
              : controller.onTapHistory,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            right: 3.98 * (w / 100),
            left: 3.98 * (w / 100),
            bottom: 3.98 * (w / 100),
          ),
          child: SingleChildScrollView(
            child: controller.isLoading
                ? const RequestDetailsShimmer()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RequestDetailsBrief(
                            user: controller.request.user,
                            request: controller.request,
                          ),
                          SizedBox(
                            height: 4.47 * (w / 100),
                          ),
                          PlanInfo(
                            plan: controller.request.plan,
                          ),
                          SizedBox(
                            height: 7.96 * (w / 100),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
        bottomNavigationBar: controller.isLoading
            ? const RequestBottomButtonsShimmer()
            : const RequestDetailsBottomBar(),
      ),
    );
  }
}

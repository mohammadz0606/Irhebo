import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/requests/requests_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/requests/widgets/request_item.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/requests/widgets/requests_screen_shimmer.dart';
import 'package:irhebo/presentation/screens/search/widgets/tag_item.dart';
import 'package:irhebo/presentation/widgets/no_data.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';

class RequestsScreen extends GetView<RequestsController> {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: NormalAppBar(
        title: "Requests",
        hasLeading: true,
        onTapBack: () => Get.find<BottomNavBarController>().onWillPop(false),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: controller.isLoading
              ? RequestsScreenShimmer()
              : controller.requests.isEmpty
                  ? NoData(
                      forHome: false,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 1 * (w / 100)),
                            child: Row(
                              children: [
                                for (int i = 0;
                                    i < controller.types.length;
                                    i++)
                                  Obx(
                                    () => SizedBox(
                                      width: 30 * (w / 100),
                                      child: TagItem(
                                        selected: controller.types[i] ==
                                            controller.selectedTab,
                                        title: controller.types[i],
                                        onTapTag: () =>
                                            controller.onTapFilter(i),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.22 * (w / 100),
                        ),
                        Column(
                          children: [
                            for (int i = 0; i < controller.requests.length; i++)
                              Visibility(
                                  visible: controller.selectedTab ==
                                          controller.requests[i].statusKey ||
                                      controller.selectedTab == "all".tr,
                                  child: RequestItem(
                                    request: controller.requests[i],
                                    nextButtonPressed: () =>
                                        controller.navigateToRequestDetails(i),
                                  )),
                          ],
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}

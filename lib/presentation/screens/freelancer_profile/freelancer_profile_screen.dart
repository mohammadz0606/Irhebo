import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/custome_paginagtion_footer.dart';
import 'package:irhebo/presentation/screens/freelancer_profile/freelancer_profile_controller.dart';
import 'package:irhebo/presentation/screens/freelancer_profile/widgets/freelancer_background.dart';
import 'package:irhebo/presentation/screens/freelancer_profile/widgets/freelancer_profile_content.dart';
import 'package:irhebo/presentation/screens/freelancer_profile/widgets/freelancer_profile_shimmer.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';
import 'package:irhebo/presentation/widgets/service_details_app_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FreelancerProfileScreen extends GetView<FreelancerProfileController> {
  const FreelancerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: AppLightColors.primaryColor,
      body: SizedBox(
        height: 100 * (h / 100),
        child: Obx(
          () => SmartRefresher(
            controller: controller.refreshController,
            onRefresh: controller.onRefreshList,
            enablePullDown: true,
            enablePullUp: true,
            footer: const CustomePaginagtionFooter(),
            onLoading: controller.getFreelancerProfile,
            child: SingleChildScrollView(
              child: controller.isLoading
                  ? const FreelancerProfileShimmer()
                  : Container(
                      color: Get.find<AppController>().darkMode
                          ? AppDarkColors.darkCover
                          : AppLightColors.primaryColor.withOpacity(0.5),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          const FreelancerBackground(),
                          const FreelancerProfileContent(),
                          Padding(
                            padding: EdgeInsets.only(top: 35.27 * (w / 100)),
                            child: AppImage(
                              imageUrl:
                                  controller.freelancer?.freelancer?.avatar ??
                                      "",
                              width: 18.9 * (w / 100),
                              height: 18.9 * (w / 100),
                              radius: 50 * (w / 100),
                            ),
                          ),
                          Positioned(
                              top: 16.41 * (w / 100),
                              child: ServiceDetailsAppBar(
                                profile: true,
                                onTapChat: controller.onTapChat,
                              )),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

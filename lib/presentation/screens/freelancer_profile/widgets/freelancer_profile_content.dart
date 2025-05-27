import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/screens/freelancer_profile/freelancer_profile_controller.dart';
import 'package:irhebo/presentation/screens/freelancer_profile/widgets/freelancer_about.dart';
import 'package:irhebo/presentation/screens/freelancer_profile/widgets/freelancer_info.dart';
import 'package:irhebo/presentation/screens/freelancer_profile/widgets/freelancer_portfolio.dart';
import 'package:irhebo/presentation/screens/search/widgets/tag_item.dart';
import 'package:irhebo/presentation/screens/service_details/widgets/reviews_section.dart';
import 'package:irhebo/presentation/widgets/no_data.dart';
import 'package:irhebo/presentation/widgets/search_service_item.dart';

class FreelancerProfileContent extends GetWidget<FreelancerProfileController> {
  const FreelancerProfileContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(top: 43.48 * (w / 100)),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: 4.47 * (w / 100), horizontal: 3.98 * (w / 100)),
          decoration: BoxDecoration(
              color: Get.find<AppController>().darkMode
                  ? AppDarkColors.darkScaffoldColor
                  : AppLightColors.scaffoldColor2,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(44), topRight: Radius.circular(44))),
          width: 100 * (w / 100),
          child: Column(
            children: [
              FreelancerInfo(
                freelancer: controller.freelancer?.freelancer,
                rating: controller.freelancer?.averageRating ?? "0",
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < ProfileTabs.values.length; i++)
                    Obx(
                      () => TagItem(
                        freelancer: true,
                        selected:
                            ProfileTabs.values[i] == controller.selectedTab,
                        title: ProfileTabs.values[i].name.tr,
                        onTapTag: () =>
                            controller.onChangeTab(ProfileTabs.values[i]),
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: 5.47 * (w / 100),
              ),
              Obx(
                () => Visibility(
                    visible: controller.selectedTab == ProfileTabs.About,
                    child: FreelancerAbout(
                      freelancer: controller.freelancer?.freelancer,
                    )),
              ),
              Obx(
                () => Visibility(
                    visible: controller.selectedTab == ProfileTabs.Reviews,
                    child: controller.reviews.isEmpty
                        ? Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: 30 * (w / 100)),
                            child: NoData(),
                          )
                        : ReviewsSection(
                            freelancer: true,
                            reviews: controller.reviews,
                            onTapFreelancer: (i) =>
                                controller.onTapFreelancerFromReviews(i),
                          )),
              ),
              Obx(
                () => Visibility(
                    visible: controller.selectedTab == ProfileTabs.Services,
                    child: controller.services.isEmpty
                        ? Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: 30 * (w / 100)),
                            child: NoData(),
                          )
                        : Column(
                            children: [
                              for (int i = 0;
                                  i < controller.services.length;
                                  i++)
                                SearchServiceItem(
                                  onLikeService: () =>
                                      controller.onLikeService(i),
                                  onTapService: () =>
                                      controller.onTapService(i),
                                  service: controller.services[i],
                                ),
                            ],
                          )),
              ),
              Obx(
                () => Visibility(
                    visible: controller.selectedTab == ProfileTabs.Portfolio,
                    child: controller.portfolios.isEmpty
                        ? Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: 30 * (w / 100)),
                            child: NoData(),
                          )
                        : FreelancerPortfolio(
                            portfolios: controller.portfolios,
                            onTapPortfolio: (i) =>
                                controller.onTapPortfolio(i))),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}

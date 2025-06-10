import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/service_item.dart';
import 'package:irhebo/presentation/screens/service_details/service_details_controller.dart';
import 'package:irhebo/presentation/screens/service_details/widgets/description_section.dart';
import 'package:irhebo/presentation/screens/service_details/widgets/info_section.dart';
import 'package:irhebo/presentation/screens/service_details/widgets/media_section.dart';
import 'package:irhebo/presentation/screens/service_details/widgets/portfolio_section.dart';
import 'package:irhebo/presentation/screens/service_details/widgets/reviews_section.dart';
import 'package:irhebo/presentation/widgets/app_title_with_action.dart';

import '../../../../app/app_functions.dart';
import '../../../../app/enums.dart';

class FreelancerInfoContainer extends GetWidget<ServiceDetailsController> {
  const FreelancerInfoContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 4.47 * (w / 100),
        horizontal: 3.98 * (w / 100),
      ),
      decoration: BoxDecoration(
          color: Get.find<AppController>().darkMode
              ? AppDarkColors.darkScaffoldColor
              : AppLightColors.scaffoldColor2,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(44), topRight: Radius.circular(44))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //if (getUserRole != UserRoles.freelancer)
            Obx(
              () => InfoSection(
                onTapChat: controller.onTapChat,
                service: controller.serviceDetails.service,
                onLikeService: controller.onLikeService,
                reviews: controller.serviceDetails.reviews?.length ?? 0,
                onTapFreelancer: controller.onTapFreelancerFromInfo,
              ),
            ),
          if (getUserRole != UserRoles.freelancer)
            const Divider(
              height: 1,
            ),
          if (controller.serviceDetails.service?.description != null)
            DescriptionSection(
              desciption: controller.serviceDetails.service?.description ?? "",
            ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.48 * (w / 100)),
            child: const Divider(
              height: 1,
            ),
          ),
          if (controller.serviceDetails.service?.media?.isNotEmpty == true)
            MediaSection(
              mediaList: controller.serviceDetails.service?.media ?? [],
              onTapServices: (i) => controller.onTapServiceMedia(i),
            ),
          if (controller.serviceDetails.portoflio?.isNotEmpty == true)
            PortfolioSection(
              portfolio: controller.serviceDetails.portoflio ?? [],
              onTapPortfolio: (i) => controller.onTapPortfolio(i),
            ),
          if (controller.moreReviews.isNotEmpty)
            Obx(
              () => ReviewsSection(
                onTapFreelancer: (i) =>
                    controller.onTapFreelancerFromReviews(i),
                onTapShowMore: () => controller.moreReviews.length <
                        controller.serviceDetails.reviews!.length
                    ? controller.showMoreReviews()
                    : null,
                isThereShowMore:
                    controller.serviceDetails.reviews!.length > 2 &&
                        (controller.serviceDetails.reviews!.length !=
                            controller.moreReviews.length),
                reviews: controller.moreReviews,
              ),
            ),
          if (getUserRole != UserRoles.freelancer)
          if (controller.serviceDetails.recommended!.isNotEmpty) ...[
            const AppTitleWithAction(
              title: "Recommended",
              services: true,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0;
                      i < controller.serviceDetails.recommended!.length;
                      i++)
                    Row(
                      children: [
                        Obx(
                          () => ServiceItem(
                            onTapFreelancer: () =>
                                controller.onTapFreelancer(i),
                            home: false,
                            onTapService: () => controller.onTapService(i),
                            service: controller.serviceDetails.recommended![i],
                            onLikeService: () =>
                                controller.onLikeRecomendedService(i),
                          ),
                        ),
                        SizedBox(
                          width: 4.47 * (w / 100),
                        )
                      ],
                    )
                ],
              ),
            )
          ]
        ],
      ),
    );
  }
}

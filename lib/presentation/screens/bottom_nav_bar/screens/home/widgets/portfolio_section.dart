// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/home_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/bottom_shadow_widget.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/portfolio_shimmer.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/video_play_widget.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';
import 'package:irhebo/presentation/widgets/app_title_with_action.dart';
import 'package:irhebo/presentation/widgets/no_data.dart';

class PortfolioSection extends GetWidget<HomeController> {
  const PortfolioSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppTitleWithAction(
          title: "Featured",
          // action: "See All",
        ),
        Obx(
          () => controller.isLoading
              ? const PortfolioShimmer()
              : controller.portfolios.isEmpty
                  ? const NoData()
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3.98 * (w / 100),
                          vertical: 2.48 * (w / 100)),
                      child: MasonryGridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisSpacing: 3.48 * (w / 100),
                        mainAxisSpacing: 3.48 * (w / 100),
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Fixed number of columns
                        ),
                        itemCount: controller.portfolios.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => controller.openFeaturedDialog(index),
                            child: Stack(
                              children: [
                                controller.portfolios[index].cover?.mediaType !=
                                        "image"
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(18),
                                        child: VideoMediaWidget(
                                            mediaUrl: controller
                                                    .portfolios[index]
                                                    .cover
                                                    ?.mediaPath ??
                                                ""),
                                      )
                                    : AppImage(
                                        imageUrl: controller.portfolios[index]
                                                .cover?.mediaPath ??
                                            "",
                                        width: 44.27 * (w / 100),
                                        height: (index % 2 != 0) ||
                                                (index ==
                                                    controller
                                                            .portfolios.length -
                                                        1)
                                            ? 35.32 * (w / 100)
                                            : 74.12 * (w / 100),
                                        radius: 18,
                                      ),
                                const Positioned(
                                  bottom: 0,
                                  child: BottomShadowWidget(),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
        ),
      ],
    );
  }
}

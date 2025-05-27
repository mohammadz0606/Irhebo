import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/wishlist/wishlist_controller.dart';
import 'package:irhebo/presentation/screens/search/widgets/search_service_shimmer.dart';
import 'package:irhebo/presentation/widgets/no_data.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';
import 'package:irhebo/presentation/widgets/search_service_item.dart';

class WishlistScreen extends GetView<WishlistController> {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: NormalAppBar(
        title: "Wishlist",
        hasLeading: true,
        onTapBack: () => Get.find<BottomNavBarController>().onWillPop(false),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: controller.isLoading
              ? SearchServiceShimmer()
              : controller.services.isEmpty
                  ? NoData(
                      forHome: false,
                    )
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.98 * (w / 100)),
                      child: Column(
                        children: [
                          for (int i = 0; i < controller.services.length; i++)
                            SearchServiceItem(
                              onTapService: () => controller.onTapService(i),
                              onLikeService: () => controller.onLikeService(i),
                              service: controller.services[i],
                            )
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}

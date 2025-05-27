import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/see_all/see_all_controller.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';

class SeeAllScreen extends GetView<SeeAllController> {
  const SeeAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: NormalAppBar(
        title: "Recommended Services",
      ),
      // body: Obx(
      //   () => SingleChildScrollView(
      //     child: controller.isLoading
      //         ? SearchServiceShimmer()
      //         : Padding(
      //             padding: EdgeInsets.symmetric(horizontal: 3.98 * (w / 100)),
      //             child: Column(
      //               children: [
      //                 // for (int i = 0; i < controller.services.length; i++)
      //                 //   SearchServiceItem(
      //                 //     onTapService: () => controller.onTapService(),
      //                 //     service: controller.services[i],
      //                 //     onLikeService: () => controller.onLikeService(i),
      //                 //   )
      //               ],
      //             ),
      //           ),
      //   ),
      // ),
    );
  }
}

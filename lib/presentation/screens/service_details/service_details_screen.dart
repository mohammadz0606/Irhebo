import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/service_details/service_details_controller.dart';
import 'package:irhebo/presentation/screens/service_details/widgets/freelancer_info_container.dart';
import 'package:irhebo/presentation/screens/service_details/widgets/service_details_shimmer.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';
import 'package:irhebo/presentation/widgets/service_details_app_bar.dart';

import '../../../app/app_functions.dart';
import '../../../app/enums.dart';

class ServiceDetailsScreen extends StatefulWidget {
  const ServiceDetailsScreen({super.key});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  var controller = Get.put(ServiceDetailsController());

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getServiceDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Obx(
        () => controller.isLoading
            ? const ServiceDetailsShimmer()
            : SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        AppImage(
                          imageUrl:
                              controller.serviceDetails.service?.cover ?? "",
                          width: 100 * (w / 100),
                          height: 63.68 * (w / 100),
                        ),
                        SizedBox(
                          height: 36.32 * (w / 100),
                          width: 100.2 * (w / 100),
                        )
                      ],
                    ),
                    Container(
                      width: 100 * (w / 100),
                      height: 63.68 * (w / 100),
                      color: Colors.black.withOpacity(0.2),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 53.48 * (w / 100)),
                      child: const FreelancerInfoContainer(),
                    ),

                      Positioned(
                        top: 16.41 * (w / 100),
                        child: const ServiceDetailsAppBar(),
                      ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          padding: EdgeInsets.symmetric(
            horizontal: 5.97 * (w / 100),
            vertical: 5.47 * (w / 100),
          ),
          child: controller.isLoading
              ? AppLoading(
                  width: 88 * (w / 100),
                  height: 13.18 * (w / 100),
                  radius: 38,
                )
              : AppButton(
                  onPressed: () => controller.onOpenPlansBottomSheet(),
                  title: "View Plans",
                ),
        ),
      ),
    );
  }
}

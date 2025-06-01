import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/profile/profile_controller.dart';
import 'package:irhebo/presentation/screens/profile/widgets/profile_header.dart';
import 'package:irhebo/presentation/screens/profile/widgets/profile_shimmer.dart';
import 'package:irhebo/presentation/screens/profile/widgets/user_info_widget.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const NormalAppBar(
        title: "Profile",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 1 * (w / 100), horizontal: 4.47 * (w / 100)),
                child: controller.isLoading
                    ? const ProfileShimmer()
                    : Column(
                        children: [
                          Column(
                            children: [
                              ProfileHeader(
                                loading: controller.isLoadingUpdate,
                                updatePicture: () => controller
                                    .updateProfileButton(forPicture: true),
                                path: controller.imagePath,
                                user: controller.user,
                                pickPicture: controller.pickPicture,
                              ),
                              UserInfoWidget(
                                user: controller.user,
                                goToUpdate: controller.goToUpdate,
                              ),
                            ],
                          )
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

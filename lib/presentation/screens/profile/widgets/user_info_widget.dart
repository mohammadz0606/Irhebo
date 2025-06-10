import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/domain/models/login_model.dart';

// import 'package:irhebo/presentation/screens/auth/create_password/create_password_screen.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/settings/widgets/user_info_row.dart';

import '../../../../app/app_functions.dart';
import '../../../../domain/models/new_models/freelancer/freelancer_user.dart';
import '../../../widgets/app_bottom_sheet.dart';
import '../../../widgets/open_file_items.dart';
import '../../auth/register/register_freelancer_screen.dart';
import '../../search/search_controller.dart';

class UserInfoWidget extends StatelessWidget {
  final UserModel? user;
  final UserFreelancerModelData? userFreelancerModelData;
  final Function() goToUpdate;
  final Function() goToUpdateFreelancerDetails;

  const UserInfoWidget({
    super.key,
    this.user,
    required this.goToUpdate,
    this.userFreelancerModelData,
    required this.goToUpdateFreelancerDetails,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        if (userFreelancerModelData != null)
          Text(
            userFreelancerModelData!.freelancer!.bio ?? "",
            style: Get.theme.textTheme.labelSmall,
          ),
        Container(
          decoration: AppDecoration.getDecorationWithRadius(
              color: Get.find<AppController>().darkMode
                  ? AppDarkColors.darkContainer2
                  : Colors.white,
              radius: 14),
          margin: EdgeInsets.symmetric(vertical: 2.48 * (w / 100)),
          padding: EdgeInsets.symmetric(
              vertical: 0.99 * (w / 100), horizontal: 3.73 * (w / 100)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserInfoRow(title: "Email", desciption: user?.email ?? ""),
              UserInfoRow(title: "Username", desciption: user?.name ?? ""),
              UserInfoRow(
                  title: "Phone Number",
                  desciption: (user!.prefix)! + (user!.phone!)),
              UserInfoRow(title: "Gender", desciption: user?.gender ?? ""),
              UserInfoRow(
                  title: "Profession", desciption: user?.profession ?? "-"),
              UserInfoRow(title: "Country", desciption: user?.country ?? ""),
              UserInfoRow(
                title: "Languages",
                desciption:
                    user?.languages?.map((e) => e.title ?? "").join(', ') ?? '',
              ),
              if (userFreelancerModelData != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Certificates'.tr,
                      style: Get.theme.textTheme.labelSmall,
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Get.bottomSheet(
                          AppBottomSheet(
                            title: "Certificates",
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: userFreelancerModelData
                                      ?.freelancer?.certificates?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                return OpenFileItems(
                                  pathUrl: userFreelancerModelData?.freelancer
                                      ?.certificates?[index].filePath,
                                  fileName: userFreelancerModelData?.freelancer
                                          ?.certificates?[index].fileName ??
                                      '',
                                );
                              },
                            ),
                          ),
                          backgroundColor: Get.find<AppController>().darkMode
                              ? AppDarkColors.darkScaffoldColor
                              : AppLightColors.pureWhite,
                          barrierColor: Get.find<AppController>().darkMode
                              ? AppDarkColors.darkContainer.withOpacity(0.3)
                              : AppLightColors.shadow.withOpacity(0.3),
                          elevation: 0,
                          isScrollControlled: false,
                        );
                      },
                      icon: const Icon(Icons.attachment),
                    ),
                  ],
                ),
            ],
          ),
        ),
        if (getUserRole == UserRoles.freelancer &&
            userFreelancerModelData?.freelancer?.status == 'unverified')
          Container(
            decoration: AppDecoration.getDecorationWithRadius(
                color: Get.find<AppController>().darkMode
                    ? AppDarkColors.darkContainer2
                    : Colors.white,
                radius: 14),
            margin: EdgeInsets.symmetric(vertical: 2.48 * (w / 100)),
            padding: EdgeInsets.symmetric(
                vertical: 0.99 * (w / 100), horizontal: 3.73 * (w / 100)),
            child: InkWell(
              onTap: () {
                Get.put(SearchControllerGetx());
                Get.toNamed(AppRoutes.vrificationFreelancerScreen);
              },
              child: const UserInfoRow(
                title: "Verify Account",
                update: true,
              ),
            ),
          ),
        Container(
          decoration: AppDecoration.getDecorationWithRadius(
              color: Get.find<AppController>().darkMode
                  ? AppDarkColors.darkContainer2
                  : Colors.white,
              radius: 14),
          margin: EdgeInsets.symmetric(vertical: 2.48 * (w / 100)),
          padding: EdgeInsets.symmetric(
              vertical: 0.99 * (w / 100), horizontal: 3.73 * (w / 100)),
          child: InkWell(
            onTap: goToUpdate,
            child: const UserInfoRow(
              title: "Edit Profile",
              update: true,
            ),
          ),
        ),
        if (getUserRole == UserRoles.freelancer)
          Container(
            decoration: AppDecoration.getDecorationWithRadius(
                color: Get.find<AppController>().darkMode
                    ? AppDarkColors.darkContainer2
                    : Colors.white,
                radius: 14),
            margin: EdgeInsets.symmetric(vertical: 2.48 * (w / 100)),
            padding: EdgeInsets.symmetric(
                vertical: 0.99 * (w / 100), horizontal: 3.73 * (w / 100)),
            child: InkWell(
              onTap: goToUpdateFreelancerDetails,
              child: const UserInfoRow(
                title: "Edit Freelancer Details",
                update: true,
              ),
            ),
          ),
        Container(
          decoration: AppDecoration.getDecorationWithRadius(
              color: Get.find<AppController>().darkMode
                  ? AppDarkColors.darkContainer2
                  : Colors.white,
              radius: 14),
          margin: EdgeInsets.symmetric(vertical: 2.48 * (w / 100)),
          padding: EdgeInsets.symmetric(
              vertical: 0.99 * (w / 100), horizontal: 3.73 * (w / 100)),
          child: InkWell(
            onTap: () => Get.toNamed(AppRoutes.createPassword,
                arguments: {"type": PasswordScreenType.update_password}),
            child: const UserInfoRow(
              title: "Change Password",
              update: true,
            ),
          ),
        ),
        if (getUserRole == UserRoles.client)
          Container(
            decoration: AppDecoration.getDecorationWithRadius(
                color: Get.find<AppController>().darkMode
                    ? AppDarkColors.darkContainer2
                    : Colors.white,
                radius: 14),
            margin: EdgeInsets.symmetric(vertical: 2.48 * (w / 100)),
            padding: EdgeInsets.symmetric(
                vertical: 0.99 * (w / 100), horizontal: 3.73 * (w / 100)),
            child: InkWell(
              /*
            if you navigate using Get.to(() => CreatePasswordScreen())
            instead of Get.toNamed(AppRoutes.createPassword),
            the binding will not be applied.
             */
              onTap: () {
                Get.put(SearchControllerGetx());
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const RegisterFreelancerScreen(),
                  ),
                );
              },
              child: const UserInfoRow(
                title: "Upgrade to Freelancer",
                update: true,
              ),
            ),
          ),
      ],
    );
  }
}

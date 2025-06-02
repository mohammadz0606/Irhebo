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
import '../../auth/register/register_freelancer_screen.dart';
import '../../search/search_controller.dart';

class UserInfoWidget extends StatelessWidget {
  final UserModel? user;
  final Function() goToUpdate;

  const UserInfoWidget({
    super.key,
    this.user,
    required this.goToUpdate,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
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
                desciption: user?.languages
                    ?.map((e) => e.title ?? "")
                    .join(', ') ?? '',
              ),
            ],
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
            onTap: () => goToUpdate(),
            child: const UserInfoRow(
              title: "Edit Profile",
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
            /*
            if you navigate using Get.to(() => CreatePasswordScreen())
            instead of Get.toNamed(AppRoutes.createPassword),
            the binding will not be applied.
             */
            onTap: () => Get.toNamed(AppRoutes.createPassword,
                arguments: {"type": PasswordScreenType.update_password}),
            child: const UserInfoRow(
              title: "Change Password",
              update: true,
            ),
          ),
        ),
        if(getUserRole == UserRoles.client)
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

Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RegisterFreelancerScreen()));
            },
            child: const UserInfoRow(
              title: "Upgrade to Freelancer",
              update: true,
            ),
          ),
        )
      ],
    );
  }
}

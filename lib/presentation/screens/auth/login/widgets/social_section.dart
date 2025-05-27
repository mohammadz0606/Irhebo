import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/screens/auth/login/widgets/social_icon.dart';
import 'package:irhebo/presentation/widgets/register_button.dart';

class SocialSection extends StatelessWidget {
  const SocialSection({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: 6.96 * (w / 100),
        ),
        Center(
          child: Text(
            "Or Continue with".tr,
            style: Get.theme.textTheme.bodySmall!.copyWith(
                color: Get.find<AppController>().darkMode
                    ? AppDarkColors.pureWhite
                    : Colors.black),
            // textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 2.48 * (w / 100),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialIcon(
              onTap: () => {},
            ),
            SizedBox(
              width: 5.47 * (w / 100),
            ),
            SocialIcon(
              onTap: () => {},
              linkedin: false,
            ),
          ],
        ),
        RegisterButton(
          login: true,
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/settings/settings_controller.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

class PrivacyPolicyShimmer extends GetView<SettingsController> {
  const PrivacyPolicyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        AppLoading(
          height: 54.22 * (w / 100),
          width: 100 * (w / 100),
          radius: 8,
        ),
        SizedBox(
          height: 7.46 * (w / 100),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.98 * (w / 100)),
          child: Column(
            children: [
              for (int i = 0; i < 4; i++)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1 * (w / 100)),
                  child: AppLoading(
                    radius: 10,
                    width: 100 * (w / 100),
                    height: 3 * (w / 100),
                  ),
                )
            ],
          ),
        )
      ],
    );
  }
}

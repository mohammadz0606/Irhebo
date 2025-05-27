import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

class ChatsShimmer extends StatelessWidget {
  const ChatsShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Get.find<AppController>().darkMode
                      ? Colors.white.withOpacity(0.5)
                      : AppLightColors.dividerColor))),
      margin: EdgeInsets.symmetric(horizontal: 4.97 * (w / 100)),
      padding: EdgeInsets.symmetric(vertical: 4.97 * (w / 100)),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppLoading(
            width: 10.69 * (w / 100),
            height: 10.69 * (w / 100),
            radius: 50 * (w / 100),
          ),
          SizedBox(
            width: 2.98 * (w / 100),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppLoading(
                height: 3 * (w / 100),
                width: 40.16 * (w / 100),
                radius: 10,
              ),
              SizedBox(
                height: 2 * (w / 100),
              ),
              AppLoading(
                height: 3 * (w / 100),
                width: 60.16 * (w / 100),
                radius: 5,
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';

class LoginRequiredDialog extends StatelessWidget {
  const LoginRequiredDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(3.98 * (w / 100)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Sorry".tr,
            style: Get.theme.textTheme.titleLarge!.copyWith(
                color: Get.find<AppController>().darkMode
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.46 * (w / 100)),
            child: AppIcon(
              path: AppIcons.ticket,
              height: 17.9 * (w / 100),
              width: 17.9 * (w / 100),
            ),
          ),
          Text(
            "You have to login".tr,
            style: Get.theme.textTheme.labelMedium!.copyWith(
                color: Get.find<AppController>().darkMode
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          // if(serviceEntity.isVideo) VideoMediaWidget(mediaUrl: serviceEntity.image??"https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4"),
          // if(serviceEntity.isVideo == false)AppImage(imageUrl: serviceEntity.image??AppImages.userImageUrl6,height: 67.91*(w/100),radius: 3.2*(w/100),),
          SizedBox(
            height: 6.46 * (w / 100),
          ),
          AppButton(
            hieght: 8.95 * (w / 100),
            // width: 25.37 * (w / 100),
            onPressed: () => Get.toNamed(AppRoutes.login),
            title: "Go to Login",
          )
        ],
      ),
    );
  }
}

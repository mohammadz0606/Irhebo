import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/domain/models/request_model.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/requests/widgets/request_status_widget.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';

class RequestItem extends StatelessWidget {
  final RequestModel request;
  final Function() nextButtonPressed;
  const RequestItem(
      {super.key, required this.request, required this.nextButtonPressed});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => nextButtonPressed(),
      child: Padding(
        padding: EdgeInsets.only(
            right: 3.98 * (w / 100),
            left: 3.98 * (w / 100),
            bottom: 2.73 * (w / 100)),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: 4.97 * (w / 100), horizontal: 5.47 * (w / 100)),
          decoration: AppDecoration.getDecorationWithRadius(
              radius: 20,
              color: Get.find<AppController>().darkMode
                  ? AppDarkColors.darkContainer2
                  : Colors.white),
          // decoration: Get.find<AppController>().darkMode
          //     ? AppDecoration.getDecorationWithRadius(
          //         radius: 20, color: AppDarkColors.darkContainer2)
          //     : AppDecoration.getDecorationWithShadow(radius: 20),
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    AppImage(
                      imageUrl: request.image ?? "",
                      width: 21.89 * (w / 100),
                      height: 22.38 * (w / 100),
                      radius: 15,
                    ),
                    SizedBox(
                      width: 3.48 * (w / 100),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            request.title ?? "",
                            style: Get.theme.textTheme.labelLarge!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: 0.64 * (w / 100),
                          ),
                          Text(
                            request.createdAt ?? "",
                            style: Get.theme.textTheme.labelSmall!.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Get.find<AppController>().darkMode
                                    ? AppDarkColors.pureWhite.withOpacity(0.4)
                                    : Colors.black.withOpacity(0.4)),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: 0.64 * (w / 100),
                          ),
                          Row(
                            children: [
                              RequestStatusWidget(
                                  status: request.statusKey.toString()),
                              if (request.needAction == true)
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1.5 * (w / 100)),
                                    child: AppIcon(
                                      path: AppIcons.alert,
                                      height: 4.5 * (w / 100),
                                      width: 4.5 * (w / 100),
                                    )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    AppIcon(
                      width: 5.47 * (w / 100),
                      height: 5.47 * (w / 100),
                      path: AppIcons.next,
                      // isSvg: false,
                      color: Get.find<AppController>().darkMode
                          ? AppDarkColors.pureWhite
                          : Colors.black,
                      matchTextDirection: true,
                    )
                  ],
                ),
                if (request.statusKey == "confirmed" ||
                    request.statusKey == "inـprogress")
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 3.98 * (w / 100), bottom: 1 * (w / 100)),
                        child: LinearProgressIndicator(
                          value: (request.progressPercentage ?? 0) / 100,
                          minHeight: 6,
                          backgroundColor: Get.find<AppController>().darkMode
                              ? AppDarkColors.darkGreen.withAlpha(90)
                              : AppLightColors.darkPrimary.withAlpha(90),
                          borderRadius: BorderRadius.circular(40),
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Get.find<AppController>().darkMode
                                  ? AppDarkColors.green
                                  : AppLightColors.primaryColor
                                      .withOpacity(0.8)),
                        ),
                      ),
                      if (request.statusKey == "confirmed" ||
                          request.statusKey == "inـprogress")
                        Text(
                          "${request.elapsedDays}/${request.totalDays}${"Days".tr}",
                          style: Get.theme.textTheme.labelSmall,
                        )
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

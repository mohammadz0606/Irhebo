import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/domain/models/request_model.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';

class RequestLogItemWidget extends StatelessWidget {
  const RequestLogItemWidget({super.key, required this.log});
  final LogModel log;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 5.9 * (w / 100), vertical: 3.9 * (w / 100)),
          child: Row(
            children: [
              AppImage(
                imageUrl: log.user?.avatar ?? "",
                height: 9.95 * (w / 100),
                width: 9.95 * (w / 100),
                radius: 500,
              ),
              SizedBox(
                width: 3.9 * (w / 100),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    log.user?.username ?? "",
                    style: Get.theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Get.find<AppController>().darkMode
                            ? AppDarkColors.pureWhite.withOpacity(0.9)
                            : Colors.black.withOpacity(0.8)),
                  ),
                  // for (int i = 0; i < (log.tasks?.length ?? 0); i++)
                  Row(
                    children: [
                      Container(
                        width: 2 * (w / 100),
                        height: 2 * (w / 100),
                        decoration: BoxDecoration(
                            color: Get.find<AppController>().darkMode
                                ? Colors.transparent
                                : AppLightColors.secondary,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                                color: Get.find<AppController>().darkMode
                                    ? AppDarkColors.pureWhite.withOpacity(0.9)
                                    : AppLightColors.primaryColor)),
                      ),
                      SizedBox(
                        width: 2 * (w / 100),
                      ),
                      Text(log.action ?? "",
                          style: Get.theme.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Get.find<AppController>().darkMode
                                  ? AppDarkColors.pureWhite.withOpacity(0.9)
                                  : Colors.black))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

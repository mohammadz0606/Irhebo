import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/domain/models/notification_model.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationModel notification;

  const NotificationWidget({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      // color: (notification.isGeneral == true)
      //     ? Get.find<AppController>().darkMode
      //         ? AppDarkColors.darkContainer2
      //         : AppLightColors.secondary
      //     : null,
      padding: EdgeInsets.symmetric(vertical: 4.97 * (w / 100)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.97 * (w / 100)),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              // alignment: AlignmentDirectional.topStart,
              // clipBehavior: Clip.none,
              children: [
                AppImage(
                  imageUrl: notification.icon ?? "",
                  width: 10.69 * (w / 100),
                  height: 10.69 * (w / 100),
                  radius: 50 * (w / 100),
                ),
                // if (notification.newOne == true)
                //   PositionedDirectional(
                //     start: -(1*(w/100)),
                //     top: (1*(w/100)),
                //     child: Visibility(
                //       visible: 6 > 0,
                //       child: Container(
                //         height: 3.5*(w/100),
                //         width: 3.5*(w/100),
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(30),
                //             shape: BoxShape.rectangle,
                //             border: Border.all(
                //                 color: AppColors.pureWhite, width: 1),
                //             color: Colors.red),
                //       ),
                //     ),
                //   )
              ],
            ),
            SizedBox(
              width: 2.98 * (w / 100),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title ?? "",
                          style: Get.theme.textTheme.labelLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 2 * (w / 100),
                      ),
                      Text(
                        notification.createdAt ?? "",
                        style: Get.theme.textTheme.labelSmall!.copyWith(
                            color: Get.find<AppController>().darkMode
                                ? AppDarkColors.pureWhite.withOpacity(0.5)
                                : Colors.black.withOpacity(0.5)),
                      ),
                    ],
                  ),
                  Text(
                    notification.description ?? "",
                    style: Get.theme.textTheme.bodySmall,
                    // maxLines: 2,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

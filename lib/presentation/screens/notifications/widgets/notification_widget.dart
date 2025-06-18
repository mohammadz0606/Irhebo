import 'package:irhebo/domain/models/notification_model.dart';
import 'package:irhebo/domain/providers/notification.dart';

import '../../../../app/global_imports.dart';
import '../../../widgets/waiting_screen.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationModel notification;

  const NotificationWidget({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Consumer<NotificationProvider>(
      builder: (context, provider, _) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Visibility(
              visible: !provider.navigateToLoading,
              replacement: const Center(child: CircularProgressIndicator.adaptive()),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                // leading: AppImage(
                //   imageUrl: notification.icon ?? "",
                //   width: 10.69 * (w / 100),
                //   height: 10.69 * (w / 100),
                //   radius: 50 * (w / 100),
                // ),
                onTap: () async {
                  provider.navigationTo(
                      id: int.tryParse(notification.typeId ?? '0') ?? 0,
                      notificationType: notification.type);
                  if (notification.isRead == 0) {
                    await provider.markAsRead(notification.id ?? 0);
                  }
                },
                title: Text(
                  notification.title ?? "",
                  style: Get.theme.textTheme.labelLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  notification.body ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Get.theme.textTheme.labelSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: notification.isRead == 0,
                      replacement: const SizedBox(),
                      child: CircleAvatar(
                        radius: 5.r,
                        backgroundColor: AppLightColors.redBadge,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      notification.createdAt?.formatTimeAgo ?? '',
                      style: Get.theme.textTheme.labelSmall!.copyWith(
                          color: Get.find<AppController>().darkMode
                              ? AppDarkColors.pureWhite.withOpacity(0.5)
                              : Colors.black.withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
            ),
            //const WaitingScreen()
            // Visibility(
            //   visible: provider.navigateToLoading,
            //   child: const WaitingScreen(),
            // )
          ],
        );
      },
    );
  }
}
/*
Container(
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
 */

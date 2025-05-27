import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/custome_paginagtion_footer.dart';
import 'package:irhebo/presentation/screens/notifications/notifications_controller.dart';
import 'package:irhebo/presentation/screens/notifications/widgets/notifications_list.dart';
import 'package:irhebo/presentation/screens/notifications/widgets/notifications_shimmer.dart';
import 'package:irhebo/presentation/widgets/no_data.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationsScreen extends GetView<NotificationsController> {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: NormalAppBar(
        title: "Notificaations",
      ),
      body: Obx(
        () => SmartRefresher(
          controller: controller.refreshController,
          onRefresh: controller.onRefreshList,
          enablePullDown: true,
          enablePullUp: true,
          footer: CustomePaginagtionFooter(),
          onLoading: controller.getNotifications,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.98 * (w / 100)),
                  child: controller.isLoading
                      ? NotificationsShimmer()
                      : controller.notifications.isEmpty
                          ? NoData(
                              forHome: false,
                            )
                          : NotificationsTodayList(
                              notifications: controller.notifications,
                            ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

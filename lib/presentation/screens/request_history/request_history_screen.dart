import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/screens/chat/widgets/date_widget.dart';
import 'package:irhebo/presentation/screens/request_history/request_history_controller.dart';
import 'package:irhebo/presentation/screens/request_history/widgets/request_log_item_widget.dart';
import 'package:irhebo/presentation/widgets/no_data.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';

import '../../../app/router/routes.dart';

class RequestHistoryScreen extends GetView<RequestHistoryController> {
  const RequestHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: NormalAppBar(
        title: 'Request History'.tr,
        onTapBack: controller.onTapBack,
      ),
      body: SingleChildScrollView(
        child: controller.groupedLogs.isEmpty
            ? const NoData(
          forHome: false,
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8.2 * (w / 100),
                ),
                Obx(
                      () =>
                      Padding(
                        padding: EdgeInsets.only(bottom: 10 * (w / 100)),
                        child: ListView.builder(
                          shrinkWrap: true,
                          reverse: true, // Newest messages at the bottom
                          itemCount:
                          (controller.groupedLogs.keys.toList()).length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Date Header
                                DateWidget(
                                  forRequest: true,
                                  date: (controller.groupedLogs.keys
                                      .toList())[index],
                                ),
                                for (int i = 0;
                                i <
                                    controller
                                        .groupedLogs[(controller
                                        .groupedLogs.keys
                                        .toList())[index]]!
                                        .reversed
                                        .toList()
                                        .length;
                                i++)
                                  RequestLogItemWidget(
                                      log: controller
                                          .groupedLogs[(controller
                                          .groupedLogs.keys
                                          .toList())[index]]!
                                          .reversed
                                          .toList()[i]),

                                Container(
                                  height: 0.1 * (w / 100),
                                  color: Get
                                      .find<AppController>()
                                      .darkMode
                                      ? AppDarkColors.pureWhite
                                      : Colors.black,
                                  width: 100 * (w / 100),
                                ),
                                SizedBox(
                                  height: 3.9 * (w / 100),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

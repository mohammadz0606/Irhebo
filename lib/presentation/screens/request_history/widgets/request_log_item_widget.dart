import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/domain/models/request_model.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';
import 'package:irhebo/presentation/widgets/open_file_items.dart';

import '../../../../app/router/routes.dart';
import '../../../widgets/app_bottom_sheet.dart';

class RequestLogItemWidget extends StatelessWidget {
  const RequestLogItemWidget({super.key, required this.log});

  final LogModel log;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.freelancerProfile,
                arguments: {"id": log.user?.id ?? 0});
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 5.9 * (w / 100), vertical: 3.9 * (w / 100)),
            child: Row(
              children: [
                Expanded(
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
                                        : AppLightColors.primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 2 * (w / 100),
                              ),
                              Text(
                                log.action ?? "",
                                style: Get.theme.textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Get.find<AppController>().darkMode
                                      ? AppDarkColors.pureWhite.withOpacity(0.9)
                                      : Colors.black,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                if (log.attachments?.isNotEmpty == true) ...{
                  IconButton(
                    onPressed: () {
                      Get.bottomSheet(
                        AppBottomSheet(
                          title: "Attachments",
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: log.attachments?.length ?? 0,
                            itemBuilder: (context, index) {
                              return OpenFileItems(
                                pathUrl: log.attachments?[index].mediaPath,
                                fileName: extractFileName(
                                    log.attachments?[index].mediaPath ?? ""),
                              );
                            },
                          ),
                        ),
                        backgroundColor: Get.find<AppController>().darkMode
                            ? AppDarkColors.darkScaffoldColor
                            : AppLightColors.pureWhite,
                        barrierColor: Get.find<AppController>().darkMode
                            ? AppDarkColors.darkContainer.withOpacity(0.3)
                            : AppLightColors.shadow.withOpacity(0.3),
                        elevation: 0,
                        isScrollControlled: false,
                      );
                    },
                    icon: const Icon(Icons.attachment),
                  ),
                }
              ],
            ),
          ),
        ),
      ],
    );
  }

  String extractFileName(String url) {
    return Uri.parse(url).pathSegments.last;
  }
}

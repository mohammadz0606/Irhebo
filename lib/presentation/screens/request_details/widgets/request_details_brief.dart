import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/domain/models/login_model.dart';
import 'package:irhebo/domain/models/request_model.dart';
import 'package:irhebo/presentation/screens/request_details/widgets/request_details_account_info.dart';

class RequestDetailsBrief extends StatelessWidget {
  const RequestDetailsBrief(
      {super.key,
      required this.request,
      required this.user,
      this.haveIcon = true});
  final RequestModel? request;
  final UserModel? user;
  final bool haveIcon;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 5.22 * (w / 100),
        ),
        RequestDetailsAccountInfo(
          user: user,
          haveIcon: haveIcon,
          rate: request?.service?.rating ?? 0,
        ),
        SizedBox(
          height: 7.71 * (w / 100),
        ),
        Text(
          request?.service?.title ?? "",
          style: Get.theme.textTheme.labelLarge,
        ),
        SizedBox(
          height: 2.73 * (w / 100),
        ),
        Text(
          request?.service?.description ?? "",
          style: Get.theme.textTheme.bodyMedium?.copyWith(
              color: Get.find<AppController>().darkMode
                  ? AppDarkColors.pureWhite.withOpacity(0.4)
                  : Colors.black.withOpacity(0.4)),
        ),
        SizedBox(
          height: 7.71 * (w / 100),
        ),
        Container(
          width: 100 * (w / 100),
          padding: EdgeInsets.symmetric(
            vertical: 1.99 * (w / 100),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: AppDarkColors.primaryColor.withOpacity(0.2)),
          child: Text(
            request?.plan?.title ?? "",
            textAlign: TextAlign.center,
            style: Get.theme.textTheme.labelLarge
                ?.copyWith(color: AppDarkColors.primaryColor),
          ),
        ),
      ],
    );
  }
}

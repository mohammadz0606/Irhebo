// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/resources/style/text_style.dart';
import 'package:irhebo/domain/models/login_model.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';

class FreelancerWidget extends StatelessWidget {
  final bool home;
  final bool forDialog;
  final Function()? onLongPress;
  final UserModel? freelancerEntity;
  const FreelancerWidget({
    super.key,
    required this.freelancerEntity,
    this.home = true,
    this.onLongPress,
    this.forDialog = false,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Row(
      children: [
        GestureDetector(
          onLongPress: home ? onLongPress : null,
          child: AppImage(
            imageUrl: freelancerEntity?.avatar ?? "",
            width: forDialog ? 11.19 * (w / 100) : 9.95 * (w / 100),
            height: forDialog ? 11.19 * (w / 100) : 9.95 * (w / 100),
            radius: 50 * (w / 100),
          ),
        ),
        SizedBox(
          width: 1.49 * (w / 100),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              freelancerEntity?.username ?? "",
              style: forDialog
                  ? Get.theme.textTheme.labelLarge
                  : home
                      ? Get.theme.textTheme.labelMedium
                      : Get.theme.textTheme.labelLarge,
            ),
            Text(
              freelancerEntity?.profession ?? "",
              style: forDialog
                  ? Get.theme.textTheme.bodySmall
                  : home
                      ? Get.theme.textTheme.bodySmall!
                          .copyWith(fontSize: AppTextStyle.size12)
                      : Get.theme.textTheme.bodyMedium!,
            ),
          ],
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/global_imports.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/text_style.dart';
import 'package:irhebo/domain/models/freelancer_details_model.dart';
import 'package:irhebo/presentation/screens/freelancer_profile/widgets/about_info_row.dart';

class FreelancerAbout extends StatelessWidget {
  final FreelancerModel? freelancer;

  const FreelancerAbout({super.key, required this.freelancer});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        // Text(
        //   freelancer?. description?? "",
        //   style: Get.theme.textTheme.bodyMedium?.copyWith(
        //     fontSize: AppTextStyle.size16,
        //     color: AppLightColors.green,
        //   ),
        // ),
        // SizedBox(
        //   height: 2.48 * (w / 100),
        // ),
        AboutInfoRow(
         //icon: AppIcons.user,
          info: freelancer?.bio ?? "",
        ),
        SizedBox(
          height: 2.48 * (w / 100),
        ),
        AboutInfoRow(
          icon: AppIcons.user,
          info: freelancer?.gender ?? "",
        ),
        SizedBox(
          height: 2.48 * (w / 100),
        ),
        AboutInfoRow(
          icon: AppIcons.location,
          info: freelancer?.country ?? "",
        ),
        SizedBox(
          height: 2.48 * (w / 100),
        ),
        AboutInfoRow(
          icon: AppIcons.availability,
          info: freelancer?.status ?? "",
        ),
        SizedBox(
          height: 2.48 * (w / 100),
        ),
        AboutInfoRow(
          icon: AppIcons.experience,
          info: freelancer?.status ?? "",
        ),
        SizedBox(
          height: 2.48 * (w / 100),
        ),
        // AboutInfoRow(
        //   icon: AppIcons.projects,
        //   info: freelancer?.status ?? "",
        // ),
        // SizedBox(
        //   height: 2.48 * (w / 100),
        // ),
        AboutInfoRow(
          icon: AppIcons.language,
          info: freelancer?.languages
                  ?.map(
                    (e) => e.title,
                  )
                  .toString() ??
              "",
        ),

        /// TODO: IMPLEMENT SHOW CERTIFICATE
        /*

         */
      ],
    );
  }
}

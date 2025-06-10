// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/resources/images.dart';

import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/domain/models/login_model.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';
import 'package:irhebo/presentation/widgets/gradient_icon.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel? user;
  final bool loading;
  final String? path;
  final Function() pickPicture;
  final Function() updatePicture;
  const ProfileHeader({
    super.key,
    this.user,
    required this.pickPicture,
    this.path,
    required this.updatePicture,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
          top: 7.96 * (w / 100),
          bottom: 2.48 * (w / 100),
          right: 1.99 * (w / 100),
          left: 1.99 * (w / 100)),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              (path != "")
                  ? CircleAvatar(
                      radius: (1 * w) / 8,
                      backgroundImage: FileImage(File(path!)),
                    )
                  : AppImage(
                      imageUrl: user?.avatar ?? "",
                      width: 24.8 * (w / 100),
                      height: 24.8 * (w / 100),
                      radius: 100,
                    ),
              loading?const SizedBox(height:20,width:20,child: CircularProgressIndicator()):InkWell(
                onTap: () {
                  pickPicture();
                  updatePicture();
                },
                borderRadius: BorderRadius.circular(50 * (w / 100)),
                child: const GradientIcon(
                  gradient: false,
                  icn: AppIcons.camera,
                  svgColor: AppDarkColors.greenContainer,
                  bkgColor: AppDarkColors.darkContainer,
                ),
              )
            ],
          ),
          SizedBox(
            width: 2.98 * (w / 100),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user?.name ?? "",
                style: Get.theme.textTheme.labelLarge,
              ),
              Text(
                user?.profession ?? "",
                style: Get.theme.textTheme.labelMedium
                    ?.copyWith(color: AppDarkColors.greenContainer),
              ),
              SizedBox(
                height: 2.98 * (w / 100),
              ),

            ],
          ),
        ],
      ),
    );
  }
}

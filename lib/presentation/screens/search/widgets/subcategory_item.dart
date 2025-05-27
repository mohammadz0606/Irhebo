// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';

class SubcategoryItem extends StatelessWidget {
  final SubcategoryModel subcategory;
  const SubcategoryItem({
    super.key,
    required this.subcategory,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.99 * (w / 100)),
      child: Container(
        height: 16.9 * (w / 100),
        padding: EdgeInsets.symmetric(
            vertical: 3.48 * (w / 100), horizontal: 6.2 * (w / 100)),
        width: 100 * (w / 100),
        decoration: AppDecoration.getContainerWithBorder(
            radius: 20,
            color: Get.find<AppController>().darkMode
                ? AppDarkColors.darkContainer2
                : Colors.white,
            borderColor: Get.find<AppController>().darkMode
                ? null
                : Colors.black.withOpacity(0.5)),
        child: Center(
          // height: 9.95*(w/100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 7.43 * (w / 100),
                      height: 7.43 * (w / 100),
                      child: SvgPicture.network(
                        subcategory.icon ?? "",
                        fit: BoxFit.contain,
                        color: Get.find<AppController>().darkMode
                            ? null
                            : AppLightColors.primaryColor,
                        // matchTextDirection: matchTextDirection,
                      ),
                    ),
                    SizedBox(
                      width: 2.48 * (w / 100),
                    ),
                    Expanded(
                      child: Text(
                        subcategory.title ?? "",
                        style: Get.theme.textTheme.labelLarge!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              AppIcon(
                path: AppIcons.arrowRight,
                matchTextDirection: true,
                color: Get.find<AppController>().darkMode ? null : Colors.black,
                width: 5 * (w / 100),
                height: 5 * (w / 100),
              )
            ],
          ),
        ),
      ),
    );
  }
}

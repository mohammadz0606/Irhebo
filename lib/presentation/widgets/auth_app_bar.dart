import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/presentation/widgets/app_logo.dart';
import 'package:irhebo/presentation/widgets/gradient_icon.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool hasBack;
  const AuthAppBar({super.key, this.hasBack = true});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      // color: Colors.amber,
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        // clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 17.4 * (w / 100), bottom: 12.43 * (w / 100)),
            child: AppLogo(),
          ),
          Visibility(
            visible: hasBack,
            child: PositionedDirectional(
              start: 3.98 * (w / 100),
              top: 15.4 * (w / 100),
              child: InkWell(
                borderRadius: BorderRadius.circular(50 * (w / 100)),
                onTap: () => Get.back(),
                child: GradientIcon(
                  icn: AppIcons.arrowLeft,
                  matchTextDirection: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

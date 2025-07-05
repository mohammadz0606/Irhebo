import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/presentation/widgets/gradient_icon.dart';

class NormalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasLeading;
  final Function()? onTapHelp;
  final Function()? onTapFilter;
  final Function()? onTapHistory;
  final Function()? onTapClose;
  final Function()? onTapBack;
  final Color? color;
  final bool isLoading;
  final bool isThereButton;
  const NormalAppBar({
    super.key,
    required this.title,
    this.onTapBack,
    this.hasLeading = true,
    this.isLoading = false,
    this.onTapClose,
    this.onTapFilter,
    this.onTapHelp,
    this.onTapHistory,
    this.isThereButton = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: color,
      leading: hasLeading
          ? Row(
              children: [
                SizedBox(
                  width: 3.98 * (w / 100),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(50 * (w / 100)),
                  onTap: () => onTapBack != null ? onTapBack!() : Get.back(),
                  child: const GradientIcon(
                    icn: AppIcons.arrowLeft,
                    matchTextDirection: true,
                  ),
                ),
              ],
            )
          : null,
      title: Text(title.tr),
      leadingWidth: 14 * (w / 100),
      actions: [
        if (onTapFilter != null) ...[
          InkWell(
            borderRadius: BorderRadius.circular(50 * (w / 100)),
            onTap: () => onTapFilter!(),
            child: const GradientIcon(
              icn: AppIcons.filter,
              svgColor: AppDarkColors.pureWhite,
            ),
          ),
          SizedBox(
            width: 3.92 * (w / 100),
          )
        ],
        if (onTapHelp != null) ...[
          InkWell(
            borderRadius: BorderRadius.circular(50 * (w / 100)),
            onTap: () => onTapHelp!(),
            child: const GradientIcon(
              icn: AppIcons.help,
              svgColor: AppDarkColors.pureWhite,
            ),
          ),
          SizedBox(
            width: 3.92 * (w / 100),
          )
        ],
        if (onTapHistory != null) ...[
          InkWell(
            borderRadius: BorderRadius.circular(50 * (w / 100)),
            onTap: () => onTapHistory!(),
            child: const GradientIcon(
              icn: AppIcons.history,
              svgColor: AppDarkColors.pureWhite,
            ),
          ),
          SizedBox(
            width: 3.92 * (w / 100),
          )
        ],
        if (isThereButton) ...[
          GestureDetector(
            onTap: () => isLoading ? null : onTapClose!(),
            child: Container(
              decoration: AppDecoration.getDecorationWithRadius(
                  color: AppDarkColors.greenContainer,
                  borderColor: AppDarkColors.primaryColor),
              padding: EdgeInsets.symmetric(
                  vertical: 1 * (w / 100), horizontal: 3 * (w / 100)),
              child: isLoading
                  ? SizedBox(
                      width: 3.5 * (w / 100),
                      height: 3.5 * (w / 100),
                      child: const CircularProgressIndicator(
                        strokeWidth: 1,
                      ))
                  : Text(
                      "Close Ticket".tr,
                      style: Get.theme.textTheme.labelSmall!
                          .copyWith(color: Colors.white),
                    ),
            ),
          ),
          SizedBox(
            width: 3.92 * (w / 100),
          )
        ]
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

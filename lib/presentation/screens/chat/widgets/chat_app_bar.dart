import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';
import 'package:irhebo/presentation/widgets/app_text_field.dart';
import 'package:irhebo/presentation/widgets/gradient_icon.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showSearch;
  final ChatType type;
  final Function() onTapSearch;
  // final Function()? onTapBack;
  const ChatAppBar({
    super.key,
    required this.title,
    required this.type,
    required this.onTapSearch,
    required this.showSearch,
    // this.onTapBack,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        AppBar(
          leadingWidth: 14 * (w / 100),
          leading: Row(
            children: [
              SizedBox(
                width: 3.98 * (w / 100),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(50 * (w / 100)),
                onTap: () => Get.back(),
                child: GradientIcon(
                  icn: AppIcons.arrowLeft,
                  matchTextDirection: true,
                ),
              ),
            ],
          ),
          title: Row(
            children: [
              AppIcon(
                path: AppImages.bot,
                height: 6.96 * (w / 100),
                width: 6.96 * (w / 100),
                isSvg: false,
              ),
              SizedBox(
                width: 2 * (w / 100),
              ),
              Text(
                type == ChatType.Bot ? "My Bot" : title,
                style: Get.theme.textTheme.titleSmall!.copyWith(
                    color: Get.find<AppController>().darkMode
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          actions: type == ChatType.Bot
              ? []
              : [
                  InkWell(
                    borderRadius: BorderRadius.circular(50 * (w / 100)),
                    child: GradientIcon(
                      icn: AppIcons.call,
                    ),
                  ),
                  SizedBox(
                    width: 2.48 * (w / 100),
                  ),
                  InkWell(
                    onTap: () => onTapSearch(),
                    borderRadius: BorderRadius.circular(50 * (w / 100)),
                    child: GradientIcon(
                      icn: AppIcons.searchIcon,
                    ),
                  ),
                  SizedBox(
                    width: 3.92 * (w / 100),
                  ),
                ],
        ),
        if (showSearch)
          AppTextField(
            controller: TextEditingController(),
            hint: "Search here",
            isSearch: true,
            isChat: true,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

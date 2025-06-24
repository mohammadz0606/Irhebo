import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/domain/models/login_model.dart';
import 'package:irhebo/domain/providers/chat/chat_provider.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';
import 'package:irhebo/presentation/widgets/decorated_icon.dart';
import 'package:irhebo/presentation/widgets/rating_stars.dart';

import '../../../../app/global_imports.dart';

class RequestDetailsAccountInfo extends StatelessWidget {
  const RequestDetailsAccountInfo(
      {super.key, required this.user, this.haveIcon = true, this.rate});

  final UserModel? user;
  final int? rate;
  final bool haveIcon;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      decoration: AppDecoration.getDecorationWithRadius(
          radius: 16,
          color: Get.find<AppController>().darkMode
              ? AppDarkColors.dark3
              : Colors.black.withOpacity(0.06)),
      padding: EdgeInsets.symmetric(
          horizontal: 3.37 * (w / 100), vertical: 3.47 * (w / 100)),
      child: Row(
        children: [
          AppImage(
            imageUrl: user?.avatar ?? "",
            width: 12.68 * (w / 100),
            height: 12.68 * (w / 100),
            radius: 50 * (w / 100),
          ),
          SizedBox(
            width: 2.23 * (w / 100),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  user?.name ?? "",
                  style: Get.theme.textTheme.labelMedium,
                ),
                //TODO
                RatingStars(count: rate ?? 0)
              ],
            ),
          ),
          if (haveIcon)
            Consumer<ChatProvider>(
              builder: (context, provider, child) {
                return Visibility(
                  visible: !provider.isLoadingStartChat,
                  replacement: const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  child: InkWell(
                      onTap: () async {
                        // Get.toNamed(AppRoutes.chat,
                        //   arguments: {"chat_type": ChatType.Users});
                        await provider.startChat(
                          freelancerId: user?.id ?? 0,
                        );
                      },
                      child: DecoratedIcon(
                        decoration: Get.find<AppController>().darkMode
                            ? null
                            : BoxDecoration(
                                color: AppLightColors.secondary,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: AppLightColors.primaryColor)),
                        padding: 2.23 * (w / 100),
                        imagePath: AppIcons.message,
                        width: 9.95 * (w / 100),
                        height: 9.95 * (w / 100),
                      )),
                );
              },
            )
        ],
      ),
    );
  }
}

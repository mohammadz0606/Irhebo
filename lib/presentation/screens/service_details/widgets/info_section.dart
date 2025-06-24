import 'package:irhebo/app/resources/images.dart';

import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/domain/providers/chat/chat_provider.dart';
import 'package:irhebo/presentation/widgets/decorated_icon.dart';
import 'package:irhebo/presentation/widgets/freelancer_widget.dart';
import 'package:irhebo/presentation/widgets/rating_stars.dart';

import '../../../../app/app_functions.dart';
import '../../../../app/global_imports.dart';

class InfoSection extends StatelessWidget {
  final ServiceModel? service;
  final int reviews;
  final Function() onTapFreelancer;
  final Function() onLikeService;
  final Function() onTapChat;

  const InfoSection({
    super.key,
    required this.service,
    required this.onTapFreelancer,
    required this.reviews,
    required this.onLikeService,
    required this.onTapChat,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (getUserRole != UserRoles.freelancer)
              InkWell(
                onTap: () => onTapFreelancer(),
                child: FreelancerWidget(
                  home: false,
                  freelancerEntity: service?.user,
                ),
              ),
            if (getUserRole != UserRoles.freelancer)
              Row(
                children: [
                  GestureDetector(
                      onTap: () async {},
                      child: DecoratedIcon(
                        padding: 2.23 * (w / 100),
                        imagePath: AppIcons.link,
                        width: 9.95 * (w / 100),
                        height: 9.95 * (w / 100),
                      )),
                  SizedBox(
                    width: 3 * (w / 100),
                  ),
                  Consumer<ChatProvider>(
                    builder: (context, provider, _) {
                      return Visibility(
                        visible: !provider.isLoadingStartChat,
                        replacement: const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                        child: GestureDetector(
                            onTap: () async {
                              //onTapChat();
                              await provider.startChat(
                                freelancerId: service?.user?.id ?? 0,
                              );
                            },
                            child: DecoratedIcon(
                              padding: 2.23 * (w / 100),
                              imagePath: AppIcons.message,
                              width: 9.95 * (w / 100),
                              height: 9.95 * (w / 100),
                            )),
                      );
                    },
                  ),
                  SizedBox(
                    width: 3 * (w / 100),
                  ),
                  GestureDetector(
                    onTap: () => onLikeService(),
                    child: DecoratedIcon(
                      width: 9.95 * (w / 100),
                      height: 9.95 * (w / 100),
                      padding: 2.23 * (w / 100),
                      color: Get.find<AppController>().darkMode
                          ? AppDarkColors.darkGreen.withOpacity(0.31)
                          : AppLightColors.secondary,
                      // ignore: dead_code
                      imagePath: service?.isWishlist == true
                          ? AppIcons.heart
                          : AppIcons.emptyHeart,
                      svgColor: Get.find<AppController>().darkMode
                          ? AppDarkColors.darkGreen
                          : AppLightColors.secondary,
                    ),
                  ),
                ],
              ),
          ],
        ),
        if (getUserRole != UserRoles.freelancer)
          SizedBox(
            height: 4.47 * (w / 100),
          ),
        Text(
          service?.title ?? "",
          style: Get.theme.textTheme.labelLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        if (getUserRole != UserRoles.freelancer)
          SizedBox(
            height: 1.49 * (w / 100),
          ),
        if (getUserRole != UserRoles.freelancer)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingStars(
                    count: service?.rating ?? 0,
                  ),
                  // RatingNumber(
                  //   number: (service?.rating).toString(),
                  //   small: false,
                  // ),
                  SizedBox(
                    height: 2 * (w / 100),
                  ),
                  Text(
                    "$reviews ${"reviews".tr}",
                    style: Get.theme.textTheme.labelMedium!.copyWith(
                        color: Get.find<AppController>().darkMode
                            ? AppDarkColors.pureWhite.withOpacity(0.5)
                            : Colors.black.withOpacity(0.5),
                        decoration: TextDecoration.underline),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    service?.startServiceFrom ?? "",
                    style: Get.theme.textTheme.displaySmall!.copyWith(
                      fontSize: AppTextStyle.size20,
                      color: Get.find<AppController>().darkMode
                          ? AppDarkColors.pureWhite
                          : AppLightColors.primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 1 * (w / 100),
                  ),
                  Text(
                    "Start".tr,
                    style: Get.theme.textTheme.displaySmall!.copyWith(
                      fontSize: AppTextStyle.size17,
                      fontWeight: FontWeight.w500,
                      color: Get.find<AppController>().darkMode
                          ? AppDarkColors.pureWhite
                          : AppLightColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        if (getUserRole != UserRoles.freelancer)
          SizedBox(
            height: 1.49 * (w / 100),
          ),
      ],
    );
  }
}

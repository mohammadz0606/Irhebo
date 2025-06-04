import '../../../../../../../app/global_imports.dart';
import '../../../../../../../app/resources/images.dart';
import '../../../../../../../app/router/routes.dart';
import '../../../../../../../domain/models/new_models/freelancer/freelancer_home_model.dart';
import '../../../../../../widgets/app_icon.dart';
import '../../../../../../widgets/app_image.dart';
import '../../../requests/requests_controller.dart';
import '../../../requests/widgets/request_status_widget.dart';

class FreelancerRequestItemNew extends GetView<RequestsController> {
  const FreelancerRequestItemNew({super.key, required this.data});

  final FreelancerServiceModelRequests? data;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
          right: 3.98 * (w / 100),
          left: 3.98 * (w / 100),
          bottom: 2.73 * (w / 100)),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.requestDetails,
              arguments: {"id": data?.id ?? 0, "title": data?.title})?.then(
            (value) {
              controller.getRequests();
            },
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: 4.97 * (w / 100), horizontal: 5.47 * (w / 100)),
          decoration: AppDecoration.getDecorationWithRadius(
            radius: 20,
            color: Get.find<AppController>().darkMode
                ? AppDarkColors.darkContainer2
                : Colors.white,
          ),
          // decoration: Get.find<AppController>().darkMode
          //     ? AppDecoration.getDecorationWithRadius(
          //         radius: 20, color: AppDarkColors.darkContainer2)
          //     : AppDecoration.getDecorationWithShadow(radius: 20),
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    AppImage(
                      imageUrl: data?.imageUrl ?? "",
                      width: 21.89 * (w / 100),
                      height: 22.38 * (w / 100),
                      radius: 15,
                    ),
                    SizedBox(
                      width: 3.48 * (w / 100),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data?.title ?? "",
                            style: Get.theme.textTheme.labelLarge!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: 0.64 * (w / 100),
                          ),
                          Text(
                            '${data?.createdAt?.toDateTime.formatDateWithMonthName}',
                            style: Get.theme.textTheme.labelSmall!.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Get.find<AppController>().darkMode
                                    ? AppDarkColors.pureWhite.withOpacity(0.4)
                                    : Colors.black.withOpacity(0.4)),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: 0.64 * (w / 100),
                          ),
                          Row(
                            children: [
                              RequestStatusWidget(
                                status: data?.statusKey?.toString() ?? '',
                              ),
                              if (data?.needAction == true)
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1.5 * (w / 100)),
                                    child: AppIcon(
                                      path: AppIcons.alert,
                                      height: 4.5 * (w / 100),
                                      width: 4.5 * (w / 100),
                                    )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    AppIcon(
                      width: 5.47 * (w / 100),
                      height: 5.47 * (w / 100),
                      path: AppIcons.next,
                      // isSvg: false,
                      color: Get.find<AppController>().darkMode
                          ? AppDarkColors.pureWhite
                          : Colors.black,
                      matchTextDirection: true,
                    )
                  ],
                ),
                if (data?.statusKey == "confirmed" ||
                    data?.statusKey == "inـprogress")
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 3.98 * (w / 100), bottom: 1 * (w / 100)),
                        child: LinearProgressIndicator(
                          value: (data?.progressPercentage ?? 0) / 100,
                          minHeight: 6,
                          backgroundColor: Get.find<AppController>().darkMode
                              ? AppDarkColors.darkGreen.withAlpha(90)
                              : AppLightColors.darkPrimary.withAlpha(90),
                          borderRadius: BorderRadius.circular(40),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Get.find<AppController>().darkMode
                                ? AppDarkColors.green
                                : AppLightColors.primaryColor
                                    .withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                      if (data?.statusKey == "confirmed" ||
                          data?.statusKey == "inـprogress")
                        Text(
                          "${data?.elapsedDays}/${data?.totalDays}${"Days".tr}",
                          style: Get.theme.textTheme.labelSmall,
                        )
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';

import '../../../../../../../app/global_imports.dart';
import '../../../../../../../domain/models/new_models/freelancer/freelancer_home_model.dart';
import '../../../../../../../domain/providers/freelancer/freelancer_services.dart';
import '../../../../../../widgets/app_image.dart';
import '../../../../../../widgets/pricing_widget.dart';
import '../../../../../service_details/service_details_screen.dart';
import '../../home_controller.dart';
import 'edit_or_delete.dart';

class FreelancerServiceItems extends StatelessWidget {
  const FreelancerServiceItems({super.key, required this.data, this.space});

  final FreelancerHomeModelDataServices? data;
  final double? space;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 12,
      ),
      decoration: Get.find<AppController>().darkMode
          ? null
          : AppDecoration.getDecorationWithShadow(radius: 18),
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => const ServiceDetailsScreen(),
            arguments: {"id": data?.id ?? 0},
          );
        },
        child: Stack(
          children: [
            AppImage(
              imageUrl: data?.cover ?? '',
              width: 57.46 * (w / 100),
              height: 63.38 * (w / 100),
              radius: 18,
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: w,
                height: 25 * (w / 100),
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: AppDecoration.getDecorationWithRadius(
                      color: Get.find<AppController>().darkMode
                          ? AppDarkColors.darkContainer2
                          : Colors.white,
                      radius: 18),
                  padding: EdgeInsets.only(
                    top: 2.48 * (w / 100),
                    left: 2.48 * (w / 100),
                    right: 2.48 * (w / 100),
                    bottom: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data?.title ?? '',
                        style: Get.theme.textTheme.labelMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5 * (w / 100),
                      ),
                      PricingWidget(
                        number: data?.startServiceFrom ?? '',
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 2.98 * (w / 100),
              right: 2.98 * (w / 100),
              child: EditOrDelete(
                id: data?.id ?? 0,
                space: space ?? 36,
                onDeleteTap: () {
                  showAdaptiveDialog(
                    context: Get.context!,
                    barrierDismissible: false,
                    builder: (_) {
                      return Consumer<FreelancerServicesProvider>(
                        builder: (context, provider, _) {
                          return AlertDialog.adaptive(
                            title: Text('Delete Confirmation'.tr),
                            content: Text(
                              "Are you sure you want to delete this item?".tr,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  await provider.deleteService(
                                    onSuccess: () async {
                                      await provider.onRefreshList();
                                      if (getUserRole == UserRoles.client ||
                                          getUserRole == UserRoles.non) {
                                        await Get.find<HomeController>()
                                            .getHome();
                                        await Get.find<HomeController>()
                                            .getFeaturedPortfolio();
                                      } else {
                                        await Get.find<HomeController>()
                                            .getFreelancerHome();
                                      }
                                      log('DONE DELETE PORTFOLIO');
                                    },
                                    id: data?.id ?? 0,
                                  );
                                  Navigator.of(Get.context!).pop();
                                },
                                child: Text(
                                  "Yes".tr,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(Get.context!).pop();
                                },
                                child: Text(
                                  "No".tr,
                                  style: const TextStyle(
                                    color: AppLightColors.greenText,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

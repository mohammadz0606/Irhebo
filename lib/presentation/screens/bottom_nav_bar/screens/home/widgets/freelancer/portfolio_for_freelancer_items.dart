import 'dart:developer';

import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/home_controller.dart';

import '../../../../../../../app/global_imports.dart';
import '../../../../../../../app/router/routes.dart';
import '../../../../../../../domain/models/new_models/freelancer/freelancer_home_model.dart';
import '../../../../../../../domain/providers/freelancer/freelancer_portfolio.dart';
import '../../../../../../widgets/app_dialog.dart';
import '../../../../../../widgets/app_image.dart';
import 'edit_or_delete.dart';

class PortfolioForFreelancerItems extends GetView<HomeController> {
  const PortfolioForFreelancerItems({
    super.key,
    required this.data,
  });

  final FreelancerHomeModelDataPortfolios? data;

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
      child: Stack(
        children: [
          AppImage(
            imageUrl: data?.cover?.mediaPath ?? '',
            width: 41 * (w / 100),
            height: 51 * (w / 100),
            radius: 25,
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: 41 * (w / 100),
              padding: const EdgeInsets.only(bottom: 20, right: 10, left: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppLightColors.black,
                    Colors.transparent,
                  ],
                ),
              ),
              child: Text(
                data?.title ?? '',
                style: Get.theme.textTheme.labelMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Positioned(
            top: 2.98 * (w / 100),
            right: 2.98 * (w / 100),
            child: Consumer<FreelancerPortfolioProvider>(
              builder: (context, provider, _) {
                return EditOrDelete(
                  id: data?.id ?? 0,
                  space: 19.2,
                  onEditTap: () {
                    Get.toNamed(AppRoutes.createUpdatePortfolio, arguments: {
                      'data': data,
                    });
                  },
                  onDeleteTap: () async {
                    // await provider.deletePortfolio(
                    //   onSuccess: () {
                    //     controller.onRefreshList();
                    //     log('DONE DELETE PORTFOLIO');
                    //   },
                    //   id: data?.id ?? 0,
                    // );
                    // Get.defaultDialog();

                    Get.defaultDialog(
                      title: 'Delete Confirmation'.tr,
                      middleText:
                          "Are you sure you want to delete this item?".tr,
                      textConfirm: "Yes".tr,
                      textCancel: "No".tr,
                      confirmTextColor: Colors.white,
                      buttonColor: Colors.red,
                      cancelTextColor: Colors.white,
                      onConfirm: () async {
                        await provider.deletePortfolio(
                          onSuccess: () {
                            controller.onRefreshList();
                            log('DONE DELETE PORTFOLIO');
                          },
                          id: data?.id ?? 0,
                        );
                        Get.back();
                      },
                      onCancel: () {
                        Get.back();
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
// Get.dialog(
//   barrierColor: Get.find<AppController>().darkMode
//       ? AppDarkColors.darkContainer.withOpacity(0.3)
//       : AppLightColors.shadow.withOpacity(0.3),
//   useSafeArea: true,
//   Column(),
// );

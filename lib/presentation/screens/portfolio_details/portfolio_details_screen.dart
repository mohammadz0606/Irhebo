import 'dart:developer';

import 'package:irhebo/presentation/screens/portfolio_details/portfolio_details_controller.dart';
import 'package:irhebo/presentation/screens/portfolio_details/widgets/portfolio_details_shimmer.dart';
import 'package:irhebo/presentation/screens/portfolio_details/widgets/portfolio_media.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';

import '../../../app/global_imports.dart';
import '../../../app/router/routes.dart';
import '../../../domain/providers/freelancer/freelancer_portfolio.dart';
import '../bottom_nav_bar/screens/home/widgets/freelancer/edit_or_delete.dart';

class PortfolioDetailsScreen extends GetView<PortfolioDetailsController> {
  const PortfolioDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: NormalAppBar(
        title: controller.title,
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(5.97 * (w / 100)),
            child: controller.isLoading
                ? const PortfolioDetailsShimmer()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(getUserRole == UserRoles.freelancer) ... {
                        Align(
                          alignment: Alignment.centerRight,
                          child: EditOrDelete(
                            space: 0,
                            id: controller.portfolio?.id ?? 0,
                            onEditTap: () {
                              Get.toNamed(AppRoutes.createUpdatePortfolio,
                                  arguments: {
                                    'data': controller.portfolio,
                                    'id': controller.portfolio?.id ?? 0,
                                    'title': controller.portfolio?.title,
                                  });
                            },
                            onDeleteTap: () async {
                              showAdaptiveDialog(
                                context: Get.context!,
                                barrierDismissible: false,
                                builder: (_) {
                                  return Consumer<FreelancerPortfolioProvider>(
                                    builder: (context, provider, _) {
                                      return AlertDialog.adaptive(
                                        title: Text('Delete Confirmation'.tr),
                                        content: Text(
                                          "Are you sure you want to delete this item?"
                                              .tr,
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () async {
                                              await provider.deletePortfolio(
                                                onSuccess: () {
                                                  provider.onRefreshList();
                                                  log('DONE DELETE PORTFOLIO');
                                                },
                                                id: controller.portfolio?.id ?? 0,
                                              );
                                              Navigator.of(Get.context!).pop();
                                            },
                                            child: Text(
                                              "Yes".tr,
                                              style: const TextStyle(
                                                  color: Colors.red),
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
                        const SizedBox(height: 30),
                      },
                      Text(
                        controller.portfolio?.title ?? '',
                        style: Get.theme.textTheme.bodySmall?.copyWith(
                          color: Get.find<AppController>().darkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 3 * (w / 100),
                      ),
                      const PortfolioMedia()
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
// Get.defaultDialog(
//   title: 'Delete Confirmation'.tr,
//   middleText:
//       "Are you sure you want to delete this item?".tr,
//   textConfirm: "Yes".tr,
//   textCancel: "No".tr,
//   confirmTextColor: Colors.white,
//   buttonColor: Colors.red,
//   cancelTextColor: Colors.white,
//   onConfirm: () async {
//     await provider.deletePortfolio(
//       onSuccess: () {
//         controller.onRefreshList();
//         log('DONE DELETE PORTFOLIO');
//       },
//       id: data?.id ?? 0,
//     );
//     if (Get.isDialogOpen ?? false) {
//       Get.back();
//     }
//   },
//   onCancel: () {
//     if (Get.isDialogOpen ?? false) {
//       Get.back(); // يغلق الـ dialog فقط
//     }
//   },
// );

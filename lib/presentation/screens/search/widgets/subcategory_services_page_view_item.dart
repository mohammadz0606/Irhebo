// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:irhebo/domain/models/login_model.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/category_item.dart';
import 'package:irhebo/presentation/screens/search/search_controller.dart'
    as sr;
import 'package:irhebo/presentation/screens/search/widgets/search_category_shimmer.dart';

import '../../../../app/app_controller.dart';
import '../../../../app/resources/style/colors.dart';
import '../../../../app/router/routes.dart';
import '../../../../domain/models/home_model.dart';
import '../../../widgets/no_data.dart';
import '../../bottom_nav_bar/screens/home/widgets/service_item.dart';
import '../../bottom_nav_bar/screens/home/widgets/service_item_shimmer.dart';
import '../../service_details/service_details_screen.dart';
// import 'package:irhebo/presentation/screens/intro/steps/steps_controller.dart' as sr;

class SubCategoryAndServicesPageViewItem
    extends GetWidget<sr.SearchControllerGetx> {
  const SubCategoryAndServicesPageViewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //spacing: 15,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.97 * (w / 100)),
            child: Text(
              'Sub Categories'.tr,
              style: Get.theme.textTheme.titleLarge!.copyWith(
                color: Get.find<AppController>().darkMode
                    ? AppDarkColors.pureWhite
                    : Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.97 * (w / 100)),
              child: Row(
                children: [
                  if (controller.isLoadingSubcategoriesNew)
                    const Align(
                        alignment: Alignment.topCenter,
                        child: SearchCategoryShimmer())
                  else
                    ...List.generate(
                      controller.searchModel.data?.subCategories?.length ?? 0,
                      (i) => Padding(
                        padding: EdgeInsets.only(right: 7.46 * (w / 100)),
                        child: GestureDetector(
                          onTap: () => controller.onTapSubCategory(i,pageIndex: 3),
                          child: CategoryItem(
                            category: CategoryModel(
                              id: controller
                                  .searchModel.data?.subCategories?[i]?.id,
                              title: controller
                                  .searchModel.data?.subCategories?[i]?.title,
                              icon: controller
                                  .searchModel.data?.subCategories?[i]?.icon,
                            ),
                            homeCategory: false,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          const Divider(),
          const SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.97 * (w / 100)),
            child: Text(
              'Recommended'.tr,
              style: Get.theme.textTheme.titleLarge!.copyWith(
                color: Get.find<AppController>().darkMode
                    ? AppDarkColors.pureWhite
                    : Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.97 * (w / 100)),
              child: Row(
                children: [
                  if (controller.isLoadingSubcategoriesNew)
                    Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        children: [
                          for (int i = 0; i < 5; i++) const ServiceItemShimmer()
                        ],
                      ),
                    )
                  else if (controller.searchModel.data?.services?.isEmpty ==
                      true)
                    const NoData()
                  else
                    ...List.generate(
                      controller.searchModel.data?.services?.length ?? 0,
                      (i) => ServiceItem(
                        onTapFreelancer: () {
                          Get.toNamed(AppRoutes.freelancerProfile,
                              arguments: {"id": controller.searchModel.data?.services?[i]?.user?.id ?? 0});
                        },
                        onTapService: () {
                          Get.to(() => const ServiceDetailsScreen(),
                              arguments: {"id": controller.searchModel.data?.services?[i]?.id ?? 0});
                        },
                        service: ServiceModel(
                          id: controller.searchModel.data?.services?[i]?.id,
                          title: controller
                              .searchModel.data?.services?[i]?.title,
                          cover: controller
                              .searchModel.data?.services?[i]?.cover,
                          description: controller
                              .searchModel.data?.services?[i]?.description,
                          isRecommended: controller
                              .searchModel.data?.services?[i]?.isRecommended,
                          isWishlist: controller
                              .searchModel.data?.services?[i]?.isWishlist,
                          rating: controller
                              .searchModel.data?.services?[i]?.rating,
                          startServiceFrom: controller.searchModel.data
                              ?.services?[i]?.startServiceFrom,
                          subCategoryId: controller
                              .searchModel.data?.services?[i]?.subCategoryId,
                          user: UserModel(
                            id: controller
                                .searchModel.data?.services?[i]?.user?.id,
                            username: controller.searchModel.data
                                ?.services?[i]?.user?.username,
                            name: controller.searchModel.data?.services?[i]
                                ?.user?.username,
                            profession: controller.searchModel.data
                                ?.services?[i]?.user?.profession,
                            avatar: controller
                                .searchModel.data?.services?[i]?.user?.avatar,
                          ),
                        ),
                        onLikeService: ()=> controller.onLikeService(i),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

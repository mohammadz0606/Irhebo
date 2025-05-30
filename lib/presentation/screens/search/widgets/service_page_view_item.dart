// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/custome_paginagtion_footer.dart';
import 'package:irhebo/presentation/screens/search/search_controller.dart'
    as sr;
import 'package:irhebo/presentation/screens/search/widgets/search_service_shimmer.dart';
import 'package:irhebo/presentation/screens/search/widgets/services_filters_section.dart';
import 'package:irhebo/presentation/widgets/no_data.dart';
import 'package:irhebo/presentation/widgets/search_service_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ServicePageViewItem extends GetWidget<sr.SearchControllerGetx> {
  const ServicePageViewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ServicesFiltersSection(),
          SizedBox(
            height: 2.23 * (w / 100),
          ),
          Expanded(
            child: SmartRefresher(
              controller: controller.refreshController,
              onRefresh: controller.onRefreshList,
              enablePullDown: true,
              enablePullUp: true,
              footer: CustomePaginagtionFooter(),
              onLoading: controller.onLoadingServices,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    controller.isLoadingService
                        ? SearchServiceShimmer()
                        : controller.services.isEmpty
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 50 * (w / 100)),
                                child: NoData(
                                  forHome: true,
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.98 * (w / 100)),
                                child: Column(
                                  children: [
                                    for (int i = 0;
                                        i < controller.services.length;
                                        i++)
                                      SearchServiceItem(
                                        onTapService: () =>
                                            controller.onTapService(i),
                                        onLikeService: () =>
                                            controller.onLikeService(i),
                                        service: controller.services[i],
                                      )
                                  ],
                                ),
                              )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

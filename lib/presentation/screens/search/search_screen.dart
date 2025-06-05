import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/presentation/screens/search/search_controller.dart'
    as sr;
import 'package:irhebo/presentation/screens/search/widgets/search_page_view.dart';
import 'package:irhebo/presentation/widgets/app_text_field.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';

class SearchScreen extends GetView<sr.SearchControllerGetx> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return Obx(
      () => WillPopScope(
        onWillPop: controller.onTapBack,
        child: Scaffold(
          appBar: NormalAppBar(
            title: controller.appBarTitle,
            onTapBack: controller.onTapBack,
            onTapHelp: controller.pageIndex == 1
                ? () => {
                      Get.toNamed(AppRoutes.faqs, arguments: {
                        "category_id": controller.categoryId,
                      })
                    }
                : null,
            onTapFilter:
                controller.pageIndex == 2 && !controller.isLoadingFilters
                    ? () => controller.openFilterBottomSheet()
                    : null,
          ),
          body: Column(
            children: [
              Form(
                child: AppTextField(
                  controller: controller.searchController,
                  hint: "Search here",
                  isSearch: true,
                  onChange: controller.onChangeHandler,
                ),
              ),
              SearchPageView(
                controller: controller.controller,
                onPageChanged: (index) => controller.onPageChanged(index),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

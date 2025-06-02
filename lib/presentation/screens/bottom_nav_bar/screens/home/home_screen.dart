import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/home_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/categories_section.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/custome_paginagtion_footer.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/freelancer/freelancer_quotation.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/freelancer/freelancer_request.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/freelancer/freelancer_services.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/freelancer/portfolio_for_freelancer.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/home_app_bar.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/portfolio_section.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/services_section.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/widgets/bot_floating_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../app/app_functions.dart';
import '../../../../../app/enums.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        Get.find<AppController>().showCaseView(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Get.find<AppController>().darkMode
          ? null
          : AppLightColors.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20 * (w / 100)),
        child: const HomeAppBar(),
      ),
      body: SmartRefresher(
        controller: controller.refreshController,
        onRefresh: controller.onRefreshList,
        enablePullDown: true,
        enablePullUp: getUserRole != UserRoles.freelancer ? true : false,
        footer: const CustomePaginagtionFooter(),
        onLoading: getUserRole != UserRoles.freelancer
            ? controller.getFeaturedPortfolio
            : null,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: getUserRole != UserRoles.freelancer
                ? [
                    Showcase(
                      key: Get.find<AppController>().categoriesKey,
                      description: "This is categories section".tr,
                      child: const CategoriesSection(),
                    ),
                    Showcase(
                      key: Get.find<AppController>().serviceKey,
                      description: "This is services section".tr,
                      child: const ServicesSection(),
                    ),
                    Showcase(
                      key: Get.find<AppController>().porfolioKey,
                      description: "This is porfolio section".tr,
                      child: const PortfolioSection(),
                    )
                  ]
                : [
                    Showcase(
                      key: Get.find<AppController>().requestFreelancer,
                      description: "This is request section".tr,
                      child: const FreelancerRequest(),
                    ),
                    Showcase(
                      key: Get.find<AppController>().serviceFreelancer,
                      description: "This is services section".tr,
                      child: const FreelancerServices(),
                    ),
                    Showcase(
                      key: Get.find<AppController>().porfolioFreelancerKey,
                      description: "This is porfolio section".tr,
                      child: const PortfolioForFreelancer(),
                    ),
                    Showcase(
                      key: Get.find<AppController>().quotationFreelancerKey,
                      description: "This is quotation section".tr,
                      child: const FreelancerQuotation(),
                    ),
                    const SizedBox(height: 50),
                  ],
          ),
        ),
      ),
      floatingActionButton:(getUserRole != UserRoles.freelancer)?Showcase(

          targetBorderRadius: BorderRadius.circular(50),
          key: Get.find<AppController>().botKey,
          description: "This is bot made for you".tr,
          child: const BotFloatingButton()):null,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/home_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/freelancer/portfolio_for_freelancer_items.dart';

import '../../../../../../../app/global_imports.dart';
import '../../../../../../../app/router/routes.dart';
import '../../../../../../widgets/app_title_with_action.dart';
import '../../../../../../widgets/no_data.dart';
import '../portfolio_shimmer.dart';

class PortfolioForFreelancer extends GetView<HomeController> {
  const PortfolioForFreelancer({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         AppTitleWithAction(
          title: 'Portfolio',
          action: 'See All',
          onTapAction: () => Get.toNamed(AppRoutes.myPortfolio),
        ),
        Obx(
          () => controller.isLoading
              ? const PortfolioShimmer(forClint: false)
              : (controller.freelancerHomeModel?.data?.portfolios?.isEmpty ??
                      true)
                  ? const NoData()
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 1.99 * (w / 100)),
                          for (int i = 0;
                              i <
                                  (controller.freelancerHomeModel?.data
                                          ?.portfolios?.length ??
                                      0);
                              i++)
                            PortfolioForFreelancerItems(
                              data: controller
                                  .freelancerHomeModel!.data!.portfolios![i],
                            ),
                        ],
                      ),
                    ),
        ),
      ],
    );
  }
}

import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../app/global_imports.dart';
import '../../../../app/router/routes.dart';
import '../../../../domain/models/new_models/freelancer/freelancer_home_model.dart';
import '../../../../domain/providers/freelancer/freelancer_portfolio.dart';
import '../../../widgets/app_loading.dart';
import '../../../widgets/no_data.dart';
import '../../../widgets/normal_app_bar.dart';
import '../../bottom_nav_bar/screens/home/widgets/custome_paginagtion_footer.dart';
import '../../bottom_nav_bar/screens/home/widgets/freelancer/portfolio_for_freelancer_items.dart';

class MyPortfolioScreen extends StatefulWidget {
  const MyPortfolioScreen({super.key});

  @override
  State<MyPortfolioScreen> createState() => _MyPortfolioScreenState();
}

class _MyPortfolioScreenState extends State<MyPortfolioScreen> {
  @override
  void initState() {
    Provider.of<FreelancerPortfolioProvider>(context, listen: false)
        .getPortfolioList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const NormalAppBar(
        title: "My Portfolio",
      ),
      body: Consumer<FreelancerPortfolioProvider>(
        builder: (context, provider, child) {
          return SmartRefresher(
            controller: provider.refreshController,
            onRefresh: provider.onRefreshList,
            enablePullDown: true,
            enablePullUp: true,
            footer: const CustomePaginagtionFooter(),
            onLoading: provider.getPortfolioList,
            child: provider.isLoadingGet
                ? GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 3.98 * (w / 100)),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      return const AppLoading(
                        // height: 38.8 * (w / 100),
                        // width: 100 * (w / 100),
                        radius: 18,
                      );
                    },
                  )
                : provider.portfolioList.isEmpty
                    ? const NoData(
                        forHome: false,
                      )
                    : GridView.builder(
                        padding:
                            EdgeInsets.symmetric(horizontal: 3.98 * (w / 100)),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        itemCount: provider.portfolioList.length,
                        itemBuilder: (context, index) {
                          var data = provider.portfolioList[index];
                          return PortfolioForFreelancerItems(
                            data: FreelancerHomeModelDataPortfolios(
                              id: data.id,
                              userId: data.userId,
                              cover: FreelancerHomeModelDataPortfoliosCover(
                                id: data.cover?.id,
                                mediaPath: data.cover?.mediaPath,
                                mediaType: data.cover?.mediaType,
                              ),
                              title: data.title,
                              user: FreelancerHomeModelDataPortfoliosUser(
                                id: data.user?.id,
                                username: data.user?.username,
                                profession: data.user?.profession,
                                avatar: data.user?.avatar,
                              ),
                            ),
                          );
                        },
                      ),
          );
        },
      ),
      floatingActionButton: AddButton(
        onTap: () {
          Get.toNamed(AppRoutes.createUpdatePortfolio);
        },
      ),
    );
  }
}

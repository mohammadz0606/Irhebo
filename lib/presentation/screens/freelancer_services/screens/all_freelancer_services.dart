import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../app/global_imports.dart';
import '../../../../app/router/routes.dart';
import '../../../../domain/models/new_models/freelancer/freelancer_home_model.dart';
import '../../../../domain/params/new_params/freelanser/freelancer_service_param.dart';
import '../../../../domain/providers/freelancer/freelancer_services.dart';
import '../../../widgets/app_loading.dart';
import '../../../widgets/no_data.dart';
import '../../../widgets/normal_app_bar.dart';
import '../../bottom_nav_bar/screens/home/widgets/custome_paginagtion_footer.dart';
import '../../bottom_nav_bar/screens/home/widgets/freelancer/freelancer_service_items.dart';

class AllFreelancerServices extends StatefulWidget {
  const AllFreelancerServices({super.key});

  @override
  State<AllFreelancerServices> createState() => _AllFreelancerServicesState();
}

class _AllFreelancerServicesState extends State<AllFreelancerServices> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<FreelancerServicesProvider>(context, listen: false)
          .getFreeLancerServices(
              enablePagination: true,
              data: FreelancerServiceParam(
                page: Provider.of<FreelancerServicesProvider>(context,
                        listen: false)
                    .pageNumber,
                prePage: AppConstants.PAGE_LENGTH,
              ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const NormalAppBar(
        title: "My Services",
      ),
      body: Consumer<FreelancerServicesProvider>(
        builder: (context, provider, child) {
          return SmartRefresher(
            controller: provider.refreshController,
            onRefresh: provider.onRefreshList,
            enablePullDown: true,
            enablePullUp: true,
            footer: const CustomePaginagtionFooter(),
            onLoading: () async {
              await provider.getFreeLancerServices(
                  enablePagination: true,
                  data: FreelancerServiceParam(
                    page: provider.pageNumber,
                    prePage: AppConstants.PAGE_LENGTH,
                  ));
            },
            child: provider.isLoading
                ? GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 3.98 * (w / 100)),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      return const AppLoading(
                        // height: 38.8 * (w / 100),
                        // width: 100 * (w / 100),
                        radius: 18,
                      );
                    },
                  )
                : provider.services?.isEmpty == true
                    ? const NoData(
                        forHome: false,
                      )
                    : GridView.builder(
                        padding:
                            EdgeInsets.symmetric(horizontal: 3.98 * (w / 100)),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: provider.services?.length ?? 0,
                        itemBuilder: (context, index) {
                          var data = provider.services![index];
                          return FreelancerServiceItems(
                            space: 20,
                            data: FreelancerHomeModelDataServices(
                              id: data?.id ?? 0,
                              title: data?.title,
                              user: FreelancerHomeModelDataServicesUser(
                                id: data?.user?.id,
                                profession: data?.user?.profession,
                                avatar: data?.user?.avatar,
                                username: data?.user?.username,
                              ),
                              subCategoryId: data?.subCategoryId,
                              startServiceFrom: data?.startServiceFrom,
                              rating: data?.rating,
                              isWishlist: data?.isWishlist,
                              isRecommended: data?.isRecommended,
                              cover: data?.cover,
                              description: data?.description,
                            ),
                          );
                        },
                      ),
          );
        },
      ),
      floatingActionButton: AddButton(
        onTap: () {
          Get.toNamed(AppRoutes.createService);
        },
      ),
    );
  }
}

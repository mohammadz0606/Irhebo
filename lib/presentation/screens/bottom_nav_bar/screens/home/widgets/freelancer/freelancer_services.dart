import '../../../../../../../app/global_imports.dart';
import '../../../../../../widgets/app_title_with_action.dart';
import '../../../../../../widgets/no_data.dart';
import '../../home_controller.dart';
import '../service_item_shimmer.dart';
import 'freelancer_service_items.dart';

class FreelancerServices extends GetView<HomeController> {
  const FreelancerServices({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery
        .of(context)
        .size
        .width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppTitleWithAction(
          title: 'Services',
          action: 'See All',
          //  onTapAction: () => Get.toNamed(AppRoutes.search),
        ),
        Obx(
                () =>
            controller.isLoading
                ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 1.99 * (w / 100),
                  ),
                  for (int i = 0; i < 5; i++) const ServiceItemShimmer()
                ],
              ),
            )
                : (controller.freelancerHomeModel?.data?.services?.isEmpty ??
                true)
                ? const NoData()
                : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 1.99 * (w / 100)),
                  for (int i = 0; i <
                      (controller.freelancerHomeModel?.data?.services?.length ??
                          0); i++)
                    FreelancerServiceItems(
                      data: controller.freelancerHomeModel!.data!.services![i],
                    ),
                ],
              ),
            ),
        ),
      ],
    );
  }
}

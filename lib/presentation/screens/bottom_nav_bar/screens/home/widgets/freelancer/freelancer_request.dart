import 'package:irhebo/presentation/widgets/no_data.dart';

import '../../../../../../../app/global_imports.dart';
import '../../../../../../widgets/app_loading.dart';
import '../../../../../../widgets/app_title_with_action.dart';
import '../../home_controller.dart';
import 'freelancer_request_item.dart';

class FreelancerRequest extends GetView<HomeController> {
  const FreelancerRequest({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppTitleWithAction(
          title: "Requests",
          action: "See All",
          //  onTapAction: () => Get.toNamed(AppRoutes.search),
        ),
        const SizedBox(height: 5),
        Obx(
          () => controller.isLoading
              ? Column(
                  children: [
                    for (int i = 0; i < 7; i++)
                      Padding(
                        padding: EdgeInsets.only(
                            right: 3.98 * (w / 100),
                            left: 3.98 * (w / 100),
                            bottom: 2.73 * (w / 100)),
                        child: AppLoading(
                          width: 92.1 * (w / 100),
                          height: 39.8 * (w / 100),
                          radius: 27,
                        ),
                      ),
                  ],
                )
              : (controller.freelancerHomeModel?.data?.requests?.isEmpty ??
                      true)
                  ? const NoData()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0;
                            i <
                                (controller.freelancerHomeModel?.data?.requests
                                        ?.length ??
                                    0);
                            i++)
                          FreelancerRequestItemNew(
                            data: controller
                                .freelancerHomeModel!.data!.requests![i],
                          )
                      ],
                    ),
        ),
      ],
    );
  }
}

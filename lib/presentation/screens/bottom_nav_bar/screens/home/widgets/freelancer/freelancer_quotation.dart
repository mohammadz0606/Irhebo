import '../../../../../../../app/global_imports.dart';
import '../../../../../../widgets/app_loading.dart';
import '../../../../../../widgets/app_title_with_action.dart';
import '../../../../../../widgets/no_data.dart';
import '../../../../../quotations/widgets/new_quotation_widget.dart';
import '../../../../../quotations/widgets/quotation_widget.dart';
import '../../home_controller.dart';

class FreelancerQuotation extends GetView<HomeController> {
  const FreelancerQuotation({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppTitleWithAction(
          title: 'Quotations',
          action: 'See All',
          //  onTapAction: () => Get.toNamed(AppRoutes.search),
        ),
        Obx(
          () => controller.isLoading
              ? Column(
                  children: [
                    for (int i = 0; i < 3; i++)
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 1.99 * (w / 100)),
                        child: AppLoading(
                          height: 38.8 * (w / 100),
                          width: 100 * (w / 100),
                          radius: 18,
                        ),
                      )
                  ],
                )
              : (controller.freelancerHomeModel?.data?.quotations?.isEmpty ??
                      true)
                  ? const NoData()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0;
                            i <
                                (controller.freelancerHomeModel?.data
                                        ?.quotations?.length ??
                                    0);
                            i++)
                          NewQuotationWidget(
                            data: controller
                                .freelancerHomeModel!.data!.quotations![i],
                          )
                      ],
                    ),
        ),
      ],
    );
  }
}

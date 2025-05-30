import 'package:irhebo/presentation/widgets/no_data.dart';

import '../../../../../../../app/global_imports.dart';
import '../../../../../../widgets/app_title_with_action.dart';
import '../../home_controller.dart';

class FreelancerRequest extends GetView<HomeController> {
  const FreelancerRequest({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTitleWithAction(
          title: "Requests",
          action: "See All",
          //  onTapAction: () => Get.toNamed(AppRoutes.search),
        ),

        NoData(),
      ],
    );
  }
}

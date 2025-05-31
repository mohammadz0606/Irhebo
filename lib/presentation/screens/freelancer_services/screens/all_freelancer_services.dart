import '../../../../app/global_imports.dart';
import '../../../../app/router/routes.dart';
import '../../../widgets/normal_app_bar.dart';

class AllFreelancerServices extends StatelessWidget {
  const AllFreelancerServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NormalAppBar(
        title: "My Services",
      ),
      body: Container(),
      floatingActionButton: AddButton(
        onTap: () {
          Get.toNamed(AppRoutes.createService);
        },
      ),
    );
  }
}

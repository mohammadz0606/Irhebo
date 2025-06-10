import '../../../../app/global_imports.dart';
import '../../../../domain/providers/freelancer/service.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_text_button.dart';
import '../../../widgets/normal_app_bar.dart';
import '../widgets/plan_card.dart';

class CreatePlanScreen extends StatelessWidget {
  const CreatePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const NormalAppBar(
        title: "Create Service",
      ),
      body: SafeArea(
        left: false,
        top: false,
        right: false,
        bottom: true,
        child: Consumer<ServiceProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 4.97 * (w / 100),
                right: 4.97 * (w / 100),
                bottom: 20,
                top: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create and customize your plans'.tr,
                    style: Get.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 25),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.listOfPlans.length,
                    itemBuilder: (context, index) {
                      return PlanCard(currentIndex: index);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 25);
                    },
                  ),
                  const SizedBox(height: 30),
                  AppTextButton(
                    onPressed: () {
                      provider.addPlanListUIndex();
                    },
                    text: 'Upload another plan',
                  ),
                  const SizedBox(height: 50),
                  AppButton(
                    isLoading: provider.isLoadingWithCreate,
                    title: 'Submit',
                    backGroundColor: AppLightColors.greenContainer,
                    onPressed: () async {
                      await provider.createNewService();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

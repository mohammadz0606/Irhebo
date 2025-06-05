import '../../../../app/global_imports.dart';
import '../../../../domain/providers/freelancer/service.dart';
import '../../../widgets/app_text_button.dart';
import '../../../widgets/normal_app_bar.dart';
import '../widgets/plan_card.dart';

class CreatePlanScreen extends StatefulWidget {
  const CreatePlanScreen({super.key});

  @override
  State<CreatePlanScreen> createState() => _CreatePlanScreenState();
}

class _CreatePlanScreenState extends State<CreatePlanScreen> {
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
                  const PlanCard(),

                  const SizedBox(height: 30),
                  AppTextButton(
                    onPressed: () {},
                    text: 'Upload another plan',
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

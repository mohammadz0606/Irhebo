import '../../../../app/global_imports.dart';
import '../../../../app/router/routes.dart';
import '../../../widgets/normal_app_bar.dart';

class MyPortfolioScreen extends StatelessWidget {
  const MyPortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NormalAppBar(
        title: "My Portfolio",
      ),
      body: Container(),
      floatingActionButton: AddButton(
        onTap: () {
          Get.toNamed(AppRoutes.createUpdatePortfolio);
        },
      ),
    );
  }
}

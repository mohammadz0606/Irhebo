import '../../../../app/global_imports.dart';
import '../../../widgets/normal_app_bar.dart';

class CreateNewPortfolioScreen extends StatelessWidget {
  const CreateNewPortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NormalAppBar(
        title: "Crete Portfolio",
      ),
    );
  }
}

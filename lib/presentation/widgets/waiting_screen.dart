import 'package:irhebo/app/global_imports.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppLightColors.primaryColor.withValues(alpha: 0.15),
      alignment: Alignment.center,
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

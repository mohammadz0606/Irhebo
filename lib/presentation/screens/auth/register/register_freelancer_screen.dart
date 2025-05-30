import '../../../../app/global_values.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../../widgets/auth_headline.dart';

class RegisterFreelancerScreen extends StatelessWidget {
  const RegisterFreelancerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return BackgroundImage(
      child: Scaffold(
        backgroundColor:
        Get.find<AppController>().darkMode ? null : Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(27 * (w / 100)),
            child: const AuthAppBar()),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 4.97 * (w / 100)),
          child: Column(
            children: [
              AuthHeadline(
                title: "Finish up your profile",
                subtitle: "Finish setting up your profile so others can find you and assign you to jobs!",
                bottomPadding: 8.95 * (w / 100),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

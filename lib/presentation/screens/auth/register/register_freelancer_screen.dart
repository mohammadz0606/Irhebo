import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:irhebo/presentation/screens/auth/register/widgets/upload_file.dart';

import '../../../../app/global_imports.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../../widgets/auth_headline.dart';

class RegisterFreelancerScreen extends StatefulWidget {
  const RegisterFreelancerScreen({super.key});

  @override
  State<RegisterFreelancerScreen> createState() =>
      _RegisterFreelancerScreenState();
}

class _RegisterFreelancerScreenState extends State<RegisterFreelancerScreen> {
  final TextEditingController _biography = TextEditingController();
  final TextEditingController _certificates = TextEditingController();

  @override
  void dispose() {
    _biography.dispose();
    _certificates.dispose();
    super.dispose();
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthHeadline(
                title: "Finish up your profile",
                subtitle:
                    "Finish setting up your profile so others can find you and assign you to jobs!",
                bottomPadding: 8.95 * (w / 100),
              ),
              Text(
                'Avatar'.tr,
                style: Get.textTheme.headlineSmall,
              ),
              const UploadFileWidget(),
              Text(
                'Biography'.tr,
                style: Get.textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              AppTextField(
                controller: _biography,
                hint: "Tell us a little about yourself!",
                textInputType: TextInputType.multiline,
                maxLines: 4,
                textInputAction: TextInputAction.newline,
                // onValidate: AppValidators.validateName,
              ),
              const SizedBox(height: 30),
              Text(
                'Certificates'.tr,
                style: Get.textTheme.headlineSmall,
              ),
              const UploadFileWidget(),
              AppTextField(
                controller: _certificates,
                hint: "Description",
                textInputType: TextInputType.multiline,
                maxLines: 1,
                textInputAction: TextInputAction.newline,
                // onValidate: AppValidators.validateName,
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: Text('Upload another'.tr),
              ),
              AppButton(
                onPressed: () {},
                title: "Confirm",
                isLoading: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

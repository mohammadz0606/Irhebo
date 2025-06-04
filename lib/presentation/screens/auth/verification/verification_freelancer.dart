import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

import '../../../../app/global_imports.dart';
import '../../../../domain/providers/freelancer/complete_profile.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../../widgets/auth_headline.dart';
import '../register/widgets/upload_file.dart';

class VerificationFreelancerScreen extends StatefulWidget {
  const VerificationFreelancerScreen({super.key});

  @override
  State<VerificationFreelancerScreen> createState() =>
      _VerificationFreelancerScreenState();
}

class _VerificationFreelancerScreenState
    extends State<VerificationFreelancerScreen> {
  File? file;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return BackgroundImage(
      child: Scaffold(
        backgroundColor:
            Get.find<AppController>().darkMode ? null : Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(27 * (w / 100)),
          child: const AuthAppBar(),
        ),
        body: SafeArea(
          left: false,
          top: false,
          right: false,
          bottom: true,
          child: Padding(
            padding: EdgeInsets.only(
              left: 4.97 * (w / 100),
              right: 4.97 * (w / 100),
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthHeadline(
                  title: "Verify Account",
                  subtitle: "Attach your ID or passport to verify the account",
                  bottomPadding: 8.95 * (w / 100),
                ),
                UploadFileWidget(
                  fileType: FileType.image,
                  onFileSelected: (file) {
                    if (file != null) {
                      this.file = file;
                    }
                    log('DONE PIK FILE ${file?.path}');
                  },
                ),
                const Spacer(),
                Consumer<CompleteProfileProvider>(
                  builder: (context, provider, child) {
                    return AppButton(
                      title: 'Confirm',
                      isLoading: provider.isLoadingVerifyAccount,
                      onPressed: () async {
                        if (file == null) {
                          AppSnackBar.openErrorSnackBar(
                            message: 'Please fill all fields'.tr,
                          );
                          return;
                        }
                        await provider.verifyAccount(file: file!);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

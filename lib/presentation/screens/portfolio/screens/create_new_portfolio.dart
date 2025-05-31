import 'dart:developer';

import '../../../../app/global_imports.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/normal_app_bar.dart';
import '../widgets/related_services.dart';
import '../widgets/upload_multiple_file.dart';

class CreateNewPortfolioScreen extends StatefulWidget {
  const CreateNewPortfolioScreen({super.key});

  @override
  State<CreateNewPortfolioScreen> createState() =>
      _CreateNewPortfolioScreenState();
}

class _CreateNewPortfolioScreenState extends State<CreateNewPortfolioScreen> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const NormalAppBar(
        title: "Crete Portfolio",
      ),
      body: SafeArea(
        left: false,
        top: false,
        right: false,
        bottom: true,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 4.97 * (w / 100),
            left: 4.97 * (w / 100),
            right: 4.97 * (w / 100),
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Create portfolio entries to showcase your work'.tr,
                  style: Get.textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Upload Image'.tr,
                style: Get.textTheme.labelMedium,
              ),
              UploadMultipleFile(
                onFilesSelected: (file) {
                  log('DONE PIK FILE ${file.length}');
                },
              ),
              const SizedBox(height: 25),
              Text(
                'Title'.tr,
                style: Get.textTheme.labelMedium,
              ),
              const SizedBox(height: 20),
              AppTextField(
                controller: _title,
                hint: "Enter request title",
                textInputType: TextInputType.text,
                // onValidate: AppValidators.validateName,
              ),
              const SizedBox(height: 25),
              Text(
                'Description'.tr,
                style: Get.textTheme.labelMedium,
              ),
              const SizedBox(height: 20),
              AppTextField(
                controller: _desc,
                textInputType: TextInputType.multiline,
                maxLines: 2,
                textInputAction: TextInputAction.newline,
              ),
              const SizedBox(height: 25),
              const RelatedServicesWidget(),
              const SizedBox(height: 40),
              AppButton(
                onPressed: () async {
                  /*
                   AppSnackBar.openErrorSnackBar(
                      message: 'Please fill all fields'.tr,
                    );
                   */
                },
                title: "Save",
                isLoading: false,
                backGroundColor: AppLightColors.greenContainer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

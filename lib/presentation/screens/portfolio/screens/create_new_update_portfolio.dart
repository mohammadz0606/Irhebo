import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:irhebo/presentation/screens/auth/register/widgets/upload_file.dart';

import '../../../../app/global_imports.dart';
import '../../../../domain/models/new_models/freelancer/freelancer_home_model.dart';
import '../../../../domain/params/new_params/freelanser/create_portfolio_param.dart';
import '../../../../domain/providers/freelancer/freelancer_portfolio.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/normal_app_bar.dart';
import '../widgets/related_services.dart';
import '../widgets/upload_multiple_file.dart';

class CreateNewUpdatePortfolioScreen extends StatefulWidget {
  const CreateNewUpdatePortfolioScreen({super.key});

  @override
  State<CreateNewUpdatePortfolioScreen> createState() =>
      _CreateNewUpdatePortfolioScreenState();
}

class _CreateNewUpdatePortfolioScreenState
    extends State<CreateNewUpdatePortfolioScreen> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();
  File? cove;
  final List<File> media = [];
  final List<int> services = [];
  FreelancerHomeModelDataPortfolios? dataForEdit;

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _onLoadEditData();
    super.initState();
  }

  _onLoadEditData() {
    if (Get.arguments?['data'] != null) {
      dataForEdit = Get.arguments['data'];
      _title.text = dataForEdit?.title ?? '';
      // _desc.text = dataForEdit?.d ?? '';

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: NormalAppBar(
        title: Get.arguments?['data'] != null
            ? "Update Portfolio"
            : "Crete Portfolio",
      ),
      body: SafeArea(
        left: false,
        top: false,
        right: false,
        bottom: true,
        child: Column(
          children: [
            Expanded(
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
                      'Cover'.tr,
                      style: Get.textTheme.labelMedium,
                    ),
                    UploadFileWidget(
                      fileType: FileType.image,
                      onFileSelected: (file) {
                        log('DONE PIK FILE $file');

                        cove = file;
                        setState(() {});
                      },
                    ),
                    // const SizedBox(height: 25),
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
                    RelatedServicesWidget(
                      onServicesSelected: (value) {
                        services.addAll(value);
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'Upload Image'.tr,
                      style: Get.textTheme.labelMedium,
                    ),
                    UploadMultipleFile(
                      onFilesSelected: (file) {
                        log('DONE PIK FILE ${file.length}');
                        media.addAll(file);
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            Consumer<FreelancerPortfolioProvider>(
              builder: (context, provider, child) {
                return AppButton(
                  onPressed: () async {
                    if (media.isEmpty ||
                        cove == null ||
                        _title.text.trim().isEmpty ||
                        _desc.text.trim().isEmpty ||
                        services.isEmpty) {
                      AppSnackBar.openErrorSnackBar(
                        message: 'Please fill all fields'.tr,
                      );
                      return;
                    }

                    await provider.createPortfolio(
                      CreatePortfolioParam(
                        cover: cove!,
                        description: _desc.text,
                        title: _title.text,
                        services: services,
                        media: media,
                      ),
                    );
                  },
                  title: "Save",
                  isLoading: provider.isLoadingCreate,
                  backGroundColor: AppLightColors.greenContainer,
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

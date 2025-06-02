import 'dart:developer';
import 'dart:io';

import 'package:irhebo/presentation/screens/auth/register/widgets/upload_file.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../app/global_imports.dart';
import '../../../../domain/models/home_model.dart';
import '../../../../domain/params/new_params/freelanser/complete_profile_param.dart';
import '../../../../domain/providers/freelancer/complete_profile.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_text_button.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../../widgets/auth_headline.dart';
import '../../../widgets/multi_dropdown_widget.dart';
import '../../search/search_controller.dart';

class RegisterFreelancerScreen extends StatefulWidget {
  const RegisterFreelancerScreen({super.key});

  @override
  State<RegisterFreelancerScreen> createState() =>
      _RegisterFreelancerScreenState();
}

class _RegisterFreelancerScreenState extends State<RegisterFreelancerScreen> {
  final TextEditingController _biography = TextEditingController();
  final TextEditingController _certificatesDesc = TextEditingController();
  final TextEditingController _anotherFilesDesc = TextEditingController();
  File? certificateFile;

  late final SearchControllerGetx searchController;
bool isNeedToUploadOther = false;
  File? avatar;

  List<int> categoryIds = [];
  List<File?> selectedFiles = [null];
  List<TextEditingController> fileDescriptions = [TextEditingController()];


  @override
  void initState() {
    searchController = Get.find<SearchControllerGetx>();
    searchController.getCategories();
    super.initState();
  }

  @override
  void dispose() {
    _biography.dispose();
    _certificatesDesc.dispose();
    _anotherFilesDesc.dispose();
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
        body: SafeArea(
          left: false,
          top: false,
          right: false,
          bottom: true,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 4.97 * (w / 100),
              right: 4.97 * (w / 100),
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthHeadline(
                  title: "Finish up your profile",
                  subtitle:
                      "Finish setting up your profile so others can find you and assign you to jobs!",
                  bottomPadding: 8.95 * (w / 100),
                ),
                Obx(
                  () {
                    return MultiCustomDropdown<CategoryModel?>(
                      items: searchController.categories
                          .map(
                            (category) => MultiSelectItem<CategoryModel?>(
                                category, category.title ?? ''),
                          )
                          .toList(),
                      buttonText: 'Category Choices',
                      label: "Categories",
                      onConfirm: (values) {
                        categoryIds = values
                            .map(
                              (e) => e?.id ?? 0,
                            )
                            .toList();

                        setState(() {});
                      },
                      //validators: AppValidators.languagesValidator,
                    );
                  },
                ),
                const SizedBox(height: 30),
                Text(
                  'Avatar'.tr,
                  style: Get.textTheme.headlineSmall,
                ),
                UploadFileWidget(
                  onFileSelected: (file) {
                    if(file!=null){
                      avatar = file;
                    }
                    log('DONE PIK FILE ${file?.path}');
                  },
                ),
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
                UploadFileWidget(
                  onFileSelected: (file) {
                    setState(() {
                      certificateFile = file;
                    });
                  },
                ),

                AppTextField(
                  controller: _certificatesDesc,
                  hint: "Description",
                  textInputType: TextInputType.multiline,
                  maxLines: 1,
                  textInputAction: TextInputAction.newline,
                  // onValidate: AppValidators.validateName,
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Files'.tr,
                      style: Get.textTheme.headlineSmall,
                    ),
                    if (selectedFiles.isNotEmpty)
                      ...List.generate(selectedFiles.length, (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'File ${index + 1}',
                                  style: Get.textTheme.titleMedium,
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      selectedFiles.removeAt(index);
                                      fileDescriptions.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                            UploadFileWidget(
                              onFileSelected: (file) {
                                setState(() {
                                  if (file != null) {
                                    selectedFiles[index] = file;
                                  }
                                });
                              },
                            ),
                            AppTextField(
                              controller: fileDescriptions[index],
                              hint: "Description",
                              textInputType: TextInputType.multiline,
                              maxLines: 1,
                              textInputAction: TextInputAction.newline,
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      }),
                    AppTextButton(
                      onPressed: () {
                        setState(() {
                          selectedFiles.add(null);
                          fileDescriptions.add(TextEditingController());
                        });
                      },
                      text: 'Upload another',
                    ),
                  ],
                ),


                const SizedBox(height: 30),
                Consumer<CompleteProfileProvider>(
                  builder: (context, provider, _) {
                    return AppButton(
                      onPressed: () async {
                        if (avatar != null ||
                            _biography.text.trim().isNotEmpty ||
                            categoryIds.isEmpty || certificateFile != null || selectedFiles.isNotEmpty || fileDescriptions.isNotEmpty) {
                          List<File> allFiles = [];
                          if (certificateFile != null) {
                            allFiles.add(certificateFile!);
                          }
                          allFiles.addAll(selectedFiles.whereType<File>());

                          await provider.completeProfile(
                            data: CompleteProfileParam(
                              avatar: avatar!,
                              bio: _biography.text.trim(),
                              categoryIds: categoryIds,
                              descriptions: [
                                _certificatesDesc.text,
                                ...fileDescriptions.map((e) => e.text),
                              ],
                              files: allFiles,
                            ),
                          );
                        } else {
                          AppSnackBar.openErrorSnackBar(
                            message: 'Please fill all fields'.tr,
                          );
                        }
                      },


                      title: "Confirm",
                      isLoading: provider.isLoading,
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

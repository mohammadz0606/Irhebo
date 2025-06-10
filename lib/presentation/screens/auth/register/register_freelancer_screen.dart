import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:irhebo/presentation/screens/auth/register/widgets/upload_file.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../app/global_imports.dart';
import '../../../../app/resources/images.dart';
import '../../../../domain/models/home_model.dart';
import '../../../../domain/models/new_models/freelancer/freelancer_user.dart';
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
  const RegisterFreelancerScreen({
    super.key,
    this.userFreelancerModelData,
  });

  final UserFreelancerModelData? userFreelancerModelData;

  @override
  State<RegisterFreelancerScreen> createState() =>
      _RegisterFreelancerScreenState();
}

class _RegisterFreelancerScreenState extends State<RegisterFreelancerScreen> {
  final TextEditingController _biography = TextEditingController();
  final TextEditingController _certificatesDesc = TextEditingController();

  String? avatarUrl;
  String? certificateUrl;
  List<String>? certificatesUrl;

  //final TextEditingController _anotherFilesDesc = TextEditingController();
  File? certificateFile;

  late final SearchControllerGetx searchController;
  bool isNeedToUploadOther = false;
  File? avatar;

  List<int> categoryIds = [];
  List<File?> selectedFiles = [];
  List<TextEditingController> fileDescriptions = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();

    if (!Get.isRegistered<SearchControllerGetx>()) {
      Get.put(SearchControllerGetx());
    }

    searchController = Get.find<SearchControllerGetx>();

    if (widget.userFreelancerModelData != null) {
      loading = true;
      setState(() {});
    }

    searchController.getCategories().then((_) {
      if (widget.userFreelancerModelData != null) {
        _biography.text = widget.userFreelancerModelData?.freelancer?.bio ?? '';
        //  categoryIds = widget.userFreelancerModelData?.freelancer.?
        avatarUrl = widget.userFreelancerModelData?.freelancer?.avatar;
        final certificates =
            widget.userFreelancerModelData?.freelancer?.certificates ?? [];
        certificatesUrl = [];
        for (int i = 0; i < certificates.length; i++) {
          if (i == 0) {
            _certificatesDesc.text = certificates[i].description ?? '';
            certificateUrl = certificates[i].filePath;
          } else {
            fileDescriptions.add(TextEditingController());
            selectedFiles.add(null);

            fileDescriptions[i - 1].text =
                certificates[i - 1].description ?? '';

            certificatesUrl?.add(certificates[i - 1].filePath ?? '');
          }
        }
      }

      loading = false;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _biography.dispose();
    _certificatesDesc.dispose();
    //_anotherFilesDesc.dispose();
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
          child: const AuthAppBar(),
        ),
        body: SafeArea(
          left: false,
          top: false,
          right: false,
          bottom: true,
          child: Visibility(
            visible: !loading,
            replacement: const Align(
              alignment: Alignment.topCenter,
              child: LinearProgressIndicator(),
            ),
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
                    imageStartUrl: avatarUrl,
                    fileType: FileType.image,
                    onFileSelected: (file) {
                      if (file != null) {
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
                    imageStartUrl: certificateUrl,
                    onFileSelected: (file) {
                      setState(() {
                        if (certificateFile != null) {
                          selectedFiles.remove(certificateFile);
                          certificateFile = null;
                        }
                        certificateFile = file;
                        if (certificateFile != null) {
                          selectedFiles.add(certificateFile!);
                        }
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
                      // Text(
                      //   'Files'.tr,
                      //   style: Get.textTheme.headlineSmall,
                      // ),
                      if (selectedFiles.isNotEmpty)
                        ...List.generate(selectedFiles.length, (index) {
                          return Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        icon: const AppIcon(
                                          path: AppIcons.delete,
                                          color: AppDarkColors.red,
                                          height: 30,
                                          width: 20,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            selectedFiles.removeAt(index);
                                            fileDescriptions.removeAt(index);
                                          });
                                        },
                                      ),
                                    ),
                                    UploadFileWidget(
                                      imageStartUrl: certificatesUrl?[index],
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
                                ),
                              ),
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
                          if (widget.userFreelancerModelData != null) {
                            if (_biography.text.trim().isNotEmpty ||
                                categoryIds.isEmpty ||
                                fileDescriptions.isNotEmpty) {
                              List<File> allFiles = [];
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
                          } else {
                            if (avatar != null ||
                                _biography.text.trim().isNotEmpty ||
                                categoryIds.isEmpty ||
                                certificateFile != null ||
                                selectedFiles.isNotEmpty ||
                                fileDescriptions.isNotEmpty) {
                              List<File> allFiles = [];
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
      ),
    );
  }
}

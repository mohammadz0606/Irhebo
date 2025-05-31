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
  late final SearchControllerGetx searchController;

  File? avatar;

  List<int> categoryIds = [];

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
                  onFileSelected: (file) {},
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
                AppTextButton(
                  onPressed: () {},
                  text: 'Upload another',
                ),
                const SizedBox(height: 30),
                Consumer<CompleteProfileProvider>(
                  builder: (context, provider, _) {
                    return AppButton(
                      onPressed: () async {
                        if (avatar != null ||
                            _biography.text.trim().isNotEmpty ||
                            categoryIds.isEmpty) {
                          await provider.completeProfile(
                            data: CompleteProfileParam(
                              avatar: avatar!,
                              bio: _biography.text.trim(),
                              categoryIds: categoryIds,
                              descriptions: [],
                              files: [],
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

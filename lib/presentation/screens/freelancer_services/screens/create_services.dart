import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:irhebo/domain/providers/freelancer/service.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../app/global_imports.dart';
import '../../../../app/router/routes.dart';
import '../../../../domain/models/home_model.dart';
import '../../../../domain/models/new_models/tags_model.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/dropdown_item.dart';
import '../../../widgets/dropdown_widget.dart';
import '../../../widgets/multi_dropdown_widget.dart';
import '../../../widgets/normal_app_bar.dart';
import '../../auth/register/widgets/upload_file.dart';
import '../../portfolio/widgets/upload_multiple_file.dart';
import '../../search/search_controller.dart';

class CreateServicesScreen extends StatefulWidget {
  const CreateServicesScreen({super.key});

  @override
  State<CreateServicesScreen> createState() => _CreateServicesScreenState();
}

class _CreateServicesScreenState extends State<CreateServicesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ServiceProvider>(context, listen: false).getCategories();
      Provider.of<ServiceProvider>(context, listen: false).getTags();
    });
    super.initState();
  }

  List<File> media = [];
  File? cover;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const NormalAppBar(
        title: "Create Service",
      ),
      body: SafeArea(
        left: false,
        top: false,
        right: false,
        bottom: true,
        child: Consumer<ServiceProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 4.97 * (w / 100),
                right: 4.97 * (w / 100),
                bottom: 20,
                top: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add Service details'.tr,
                    style: Get.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 25),

                  if (provider.isLoadingCategory)
                    const Center(child: CircularProgressIndicator.adaptive())
                  else
                    CustomDropdown<CategoryModel?>(
                      itemBuilder: (context, item, isDisabled, isSelected) =>
                          DropdownItem(
                        label: item?.title ?? "",
                      ),
                      showSearchBox: true,
                      label: "Categories",
                      hintText: "Category Choices",
                      items: provider.categories ?? [],
                      onChanged: provider.onChangeCategory,
                      value: provider.categoryModel,
                      itemToString: (value) => value?.title ?? "",
                    ),
                  SizedBox(height: 2.98 * (w / 100)),
                  // Subcategories
                  if (provider.categoryModel != null)
                    provider.isLoadingSubcategory
                        ? const Center(
                            child: CircularProgressIndicator.adaptive())
                        : CustomDropdown<SubcategoryModel?>(
                            itemBuilder:
                                (context, item, isDisabled, isSelected) =>
                                    DropdownItem(
                              label: item?.title ?? "",
                            ),
                            showSearchBox: true,
                            label: "Sub Categories",
                            hintText: "Category Choices",
                            items: provider.subcategories ?? [],
                            onChanged: provider.onChangeSubcategory,
                            value: provider.subcategoryModel,
                            itemToString: (value) => value?.title ?? "",
                          ),
                  const SizedBox(height: 15),
                  Text(
                    'Title'.tr,
                    style: Get.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  const AppTextField(
                    //controller: _biography,
                    hint: "Enter request title",
                    textInputType: TextInputType.text,
                    maxLines: 1,
                    textInputAction: TextInputAction.done,
                    // onValidate: AppValidators.validateName,
                  ),
                  //-------//
                  const SizedBox(height: 20),
                  Text(
                    'Description'.tr,
                    style: Get.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  const AppTextField(
                    hint: "Description",
                    textInputType: TextInputType.multiline,
                    maxLines: 4,
                    textInputAction: TextInputAction.newline,
                    // onValidate: AppValidators.validateName,
                  ),
                  //-------//
                  const SizedBox(height: 20),
                  Text(
                    'Cover Photo'.tr,
                    style: Get.textTheme.headlineSmall,
                  ),
                  //const SizedBox(height: 10),
                  UploadFileWidget(
                    fileType: FileType.image,
                    onFileSelected: (file) {
                      if (file != null) {
                        cover = file;
                      }
                      log('DONE PIK FILE ${file?.path}');
                    },
                  ),

                  Text(
                    'Media'.tr,
                    style: Get.textTheme.headlineSmall,
                  ),
                  UploadMultipleFile(
                    onFilesSelected: (file) {
                      media = file;
                    },
                  ),
                  const SizedBox(height: 20),

                  if (provider.isLoadingTags || provider.tagsList == null)
                    const Center(child: CircularProgressIndicator.adaptive())
                  else
                    MultiCustomDropdown<TagsModelData?>(
                      items: provider.tagsList!.map(
                        (e) {
                          return MultiSelectItem<TagsModelData?>(
                            e,
                            e?.slug ?? '',
                          );
                        },
                      ).toList(),
                      buttonText: 'Tags Choices'.tr,
                      label: 'Tags',
                      titleStyle: Get.textTheme.labelMedium,
                      showSelected: true,
                      onConfirm: (value) {
                        log('LEN SELECTED SERVICE ${value.length}');
                        List<int> ids = value
                            .map(
                              (e) => e?.id ?? 0,
                            )
                            .toList();

                        //widget.onServicesSelected(ids);
                      },
                    ),
                  const SizedBox(height: 25),
                  AppButton(
                    title: 'Next',
                    backGroundColor: AppLightColors.greenContainer,
                    onPressed: provider.categoryModel == null ||
                            provider.subcategoryModel == null ||
                            provider.tagsList == null
                        ? () {
                            Get.toNamed(AppRoutes.createPlan);
                          }
                        : null,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

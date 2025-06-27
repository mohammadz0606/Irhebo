import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:irhebo/domain/models/new_models/plan_model.dart';
import 'package:irhebo/domain/providers/freelancer/freelancer_services.dart';
import 'package:irhebo/domain/providers/freelancer/service.dart';
import 'package:irhebo/presentation/screens/freelancer_services/widgets/plan_card.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../app/global_imports.dart';
import '../../../../app/router/routes.dart';
import '../../../../domain/models/home_model.dart';
import '../../../../domain/models/new_models/tags_model.dart';
import '../../../../domain/providers/currency.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/dropdown_item.dart';
import '../../../widgets/dropdown_widget.dart';
import '../../../widgets/multi_dropdown_widget.dart';
import '../../../widgets/normal_app_bar.dart';
import '../../auth/register/widgets/upload_file.dart';
import '../../portfolio/widgets/upload_multiple_file.dart';

class CreateServicesScreen extends StatefulWidget {
  const CreateServicesScreen({super.key});

  @override
  State<CreateServicesScreen> createState() => _CreateServicesScreenState();
}

class _CreateServicesScreenState extends State<CreateServicesScreen> {
  String? coverURL;
  List<String>? mediaURLs;

  @override
  void initState() {
    Provider.of<ServiceProvider>(context, listen: false).disposeAll();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (Get.arguments != null) {
        await Provider.of<FreelancerServicesProvider>(Get.context!,
                listen: false)
            .getServicesDetails(
          id: Get.arguments['id'],
          onSuccess: (result) {
            var data = Provider.of<ServiceProvider>(context, listen: false);
            data.descriptionController.text = result.service?.description ?? '';
            data.titleController.text = result.service?.title ?? '';
            coverURL = result.service?.cover ?? '';
            mediaURLs = result.service?.media
                    ?.where((e) => e.isCover == false && e.mediaPath != null)
                    .map((e) => e.mediaPath!)
                    .toList() ??
                [];

            data.planListUIndex = (result.plans?.length ?? 0) - 1;
            for (int i = 0; i < (result.plans?.length ?? 0); i++) {
              if (i != 0) {
                data.listOfPlans.add(const PlanCard());
              }

              bool isSourceFile = result.plans?[i].features?[3].value == '1';
              data.sourceFile[i] = isSourceFile;

              String price =
                  result.plans?[i].features?[0].value?.split(' ')[0] ?? '';
              data.priceController[i] = TextEditingController(
                text: price.replaceAll(',', '.'),
              );

              String deliveryDays = result.plans?[i].features?[1].value ?? '';

              data.deliveryDayController[i] = TextEditingController(
                text: deliveryDays,
              );
              String revisions = result.plans?[i].features?[2].value ?? '';
              data.revisionController[i] =
                  TextEditingController(text: revisions);

              data.plan[i] = PlanModelData(
                title: result.plans?[i].title,
                id: result.plans?[i].id,
              );
            }

            setState(() {});
          },
        );
      }
      await _getDataForCreate();
    });
    super.initState();
  }

  Future<void> _getDataForCreate() async {
    await Provider.of<ServiceProvider>(Get.context!, listen: false)
        .getCategories()
        .whenComplete(
      () {
        if (Get.arguments != null) {
          var data = Provider.of<ServiceProvider>(Get.context!, listen: false);
          var serviceDetailsData = Provider.of<FreelancerServicesProvider>(
                  Get.context!,
                  listen: false)
              .serviceDetails;
          data.categoryModel = data.categories?.firstWhere((element) =>
              element.id == serviceDetailsData?.service?.categoryId);

          if (data.categoryModel != null) {
            data.onChangeCategory(data.categoryModel).whenComplete(
              () {
                data.subcategoryModel = data.subcategories?.firstWhere(
                  (element) =>
                      element.id == serviceDetailsData?.service?.subCategoryId,
                );

                if (data.subcategoryModel != null) {
                  data.onChangeSubcategory(data.subcategoryModel).whenComplete(
                    () {
                      data.selectedTage = serviceDetailsData?.service?.tags;
                      data.tagsSlug = data.selectedTage
                              ?.map((e) => e?.slug ?? '')
                              .toList() ??
                          [];
                    },
                  );
                }
              },
            );
          }

          setState(() {});
        }
      },
    );
    //Provider.of<ServiceProvider>(context, listen: false).getTags();
    await Provider.of<ServiceProvider>(Get.context!, listen: false).getPlans();
    await Provider.of<CurrencyProvider>(Get.context!, listen: false)
        .getCurrencies()
        .whenComplete(() {
      if (Get.arguments != null) {
        var data = Provider.of<ServiceProvider>(Get.context!, listen: false);
        var listOfCurrency =
            Provider.of<CurrencyProvider>(Get.context!, listen: false)
                    .currencyModel
                    ?.data ??
                [];
        AppPreferences prefs = sl<AppPreferences>();

        String currentCurrency =
            prefs.getString(key: AppPrefsKeys.CURRENCY) ?? 'USD';

        data.selectedCurrency = listOfCurrency.firstWhere(
          (element) =>
              element.code?.toLowerCase() == currentCurrency.toLowerCase(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: NormalAppBar(
        title: Get.arguments == null ? "Create Service" : "Update Service",
      ),
      body: SafeArea(
        left: false,
        top: false,
        right: false,
        bottom: true,
        child: Consumer2<ServiceProvider, FreelancerServicesProvider>(
          builder: (context, provider, provider2, child) {
            return Visibility(
              visible:
                  Get.arguments == null ? true : !provider2.isLoadingGetDetails,
              replacement: const Align(
                alignment: Alignment.topCenter,
                child: LinearProgressIndicator(),
              ),
              child: SingleChildScrollView(
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
                    if (provider.subcategoryModel != null) ...{
                      if (provider.isLoadingTags || provider.tagsList == null)
                        const Center(
                            child: CircularProgressIndicator.adaptive())
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
                          // initialValue: Get.arguments == null
                          //     ? null
                          //     : provider.selectedTage,
                          initialValue: provider.tagsList
                              ?.where(
                                (element) =>
                                    provider.tagsSlug.contains(element?.slug),
                              )
                              .toList(),

                          titleStyle: Get.textTheme.labelMedium,
                          showSelected: true,
                          onConfirm: provider.onChangeTags,
                        ),
                      const SizedBox(height: 25),
                    },

                    Text(
                      'Title'.tr,
                      style: Get.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 10),
                    AppTextField(
                      controller: provider.titleController,
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
                    AppTextField(
                      hint: "Description",
                      controller: provider.descriptionController,
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
                      imageStartUrl: coverURL,
                      fileType: FileType.image,
                      onFileSelected: provider.onChangeCover,
                    ),

                    Text(
                      'Media'.tr,
                      style: Get.textTheme.headlineSmall,
                    ),
                    UploadMultipleFile(
                      urlsImage: mediaURLs,
                      onFilesSelected: provider.onChangeMedia,
                    ),
                    const SizedBox(height: 20),

                    AppButton(
                      title: 'Next',
                      backGroundColor: AppLightColors.greenContainer,
                      onPressed: () {
                        if (Get.arguments == null) {
                          Get.toNamed(AppRoutes.createPlan);
                        } else {
                          Get.toNamed(AppRoutes.createPlan, arguments: {
                            'id': Get.arguments['id'],
                          });
                        }

                        // if (provider.titleController.text.trim().isEmpty) {
                        //   AppSnackBar.openErrorSnackBar(
                        //       message: "Title is required.".tr);
                        // } else if (provider.descriptionController.text
                        //     .trim()
                        //     .isEmpty) {
                        //   AppSnackBar.openErrorSnackBar(
                        //       message: "Description is required.".tr);
                        // } else if (provider.cover == null) {
                        //   AppSnackBar.openErrorSnackBar(
                        //       message: "Cover photo is required.".tr);
                        // } else if (provider.media.isEmpty) {
                        //   AppSnackBar.openErrorSnackBar(
                        //       message: "Media photos is required.".tr);
                        // } else if (provider.subcategoryModel == null ||
                        //     provider.subcategoryModel?.id == 0) {
                        //   AppSnackBar.openErrorSnackBar(
                        //       message: "Subcategory is required.".tr);
                        // } else {
                        //   if (Get.arguments == null) {
                        //                           Get.toNamed(AppRoutes.createPlan);
                        //                         } else {
                        //                           Get.toNamed(AppRoutes.createPlan, arguments: {
                        //                             'id': Get.arguments['id'],
                        //                           });
                        //                         }
                        // }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

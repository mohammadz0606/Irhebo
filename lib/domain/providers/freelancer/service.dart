import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:irhebo/app/router/routes.dart';

import '../../../app/global_imports.dart';
import '../../../app/network/network.dart';
import '../../../presentation/screens/freelancer_services/widgets/plan_card.dart';
import '../../models/home_model.dart';
import '../../models/new_models/currency_model.dart';
import '../../models/new_models/plan_model.dart';
import '../../models/new_models/tags_model.dart';
import '../../params/new_params/freelanser/create_service_param.dart';
import '../../usecases/home_usecases/get_categories_use_case.dart';
import '../../usecases/home_usecases/get_subcategories_use_case.dart';

class ServiceProvider extends ChangeNotifier {
  CategoryModel? categoryModel;
  List<CategoryModel>? categories;
  SubcategoryModel? subcategoryModel;
  List<SubcategoryModel>? subcategories;
  List<TagsModelData?>? tagsList;
  List<PlanModelData?>? planList;
  List<String> tagsSlug = [];
  List<TagsModelData?>? selectedTage;

  final TextEditingController titleController = TextEditingController();
  //final TextEditingController descriptionController = TextEditingController();
  final QuillController quillController = QuillController.basic();

  /*
  final delta = provider.quillController.document.toDelta();
final json = delta.toJson();

final html = quillDeltaToHtml(delta);

print(html);
   */

  File? cover;
  List<File> media = [];

  bool isLoadingCategory = false;
  bool isLoadingSubcategory = false;
  bool isLoadingTags = false;
  bool isLoadingPlan = false;

  ///LIST

  int planListUIndex = 0;
  List<PlanCard> listOfPlans = [const PlanCard()];

  List<TextEditingController> priceController = [TextEditingController()];
  List<TextEditingController> deliveryDayController = [TextEditingController()];
  List<TextEditingController> revisionController = [TextEditingController()];
  List<PlanModelData?> plan = [PlanModelData()];
  CurrencyModelData? selectedCurrency;
  List<bool> sourceFile = [false];

  bool isLoadingWithCreate = false;
  bool isLoadingUpdate = false;

  Future<void> createNewService() async {
    try {
      isLoadingWithCreate = true;
      notifyListeners();
      final error = validateServiceData(
        deliveryDayController: deliveryDayController,
        priceController: priceController,
        revisionController: revisionController,
        plan: plan,
      );

      if (error != null) {
        AppSnackBar.openErrorSnackBar(message: error.tr);
        isLoadingWithCreate = false;
        notifyListeners();
        return;
      }

      var data = CreateServiceParam(
        title: titleController.text,
        cover: cover!,
        currency: selectedCurrency?.code ?? '',
        deliveryDays:
            deliveryDayController.map((e) => int.parse(e.text)).toList(),
        description: quillController,
        media: media,
        planId: plan.map((e) => e?.id ?? 0).toList(),
        price: priceController.map((e) => double.parse(e.text)).toList(),
        revision: revisionController.map((e) => int.parse(e.text)).toList(),
        sourceFile: sourceFile,
        supCategoryId: subcategoryModel?.id ?? 0,
        tags: tagsSlug,
      );

      final response = await Network().post(
        isUploadFile: true,
        data: await data.toJson(),
        url: AppEndpoints.createService,
      );
      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoadingWithCreate = false;
        notifyListeners();
        AppSnackBar.openErrorSnackBar(message: errorMessage);
        return;
      }

      /// IMPLEMENT

      isLoadingWithCreate = false;
      notifyListeners();
      AppSnackBar.openSuccessSnackBar(
          message: 'Service Created Successfully'.tr);
      disposeAll();
      Get.offAllNamed(AppRoutes.bottomNavBar);
    } catch (error) {
      if (error is DioException) {
        AppSnackBar.openErrorSnackBar(
          message: Network().handelDioException(error),
        );
      } else {
        AppSnackBar.openErrorSnackBar(
          message: error.toString(),
        );
      }
      isLoadingWithCreate = false;
      notifyListeners();
    }
  }

  Future<void> updateService({required int id}) async {
    try {
      isLoadingUpdate = true;
      notifyListeners();
      var data = CreateServiceParam(
        title: titleController.text,
        cover: cover,
        currency: selectedCurrency?.code ?? '',
        deliveryDays:
            deliveryDayController.map((e) => int.parse(e.text)).toList(),
        description: quillController,
        media: media,
        planId: plan.map((e) => e?.id ?? 0).toList(),
        price: priceController.map((e) => double.parse(e.text)).toList(),
        revision: revisionController.map((e) => int.parse(e.text)).toList(),
        sourceFile: sourceFile,
        supCategoryId: subcategoryModel?.id ?? 0,
        tags: tagsSlug,
      );

      final response = await Network().post(
        isUploadFile: true,
        data: await data.toJson(),
        url: '${AppEndpoints.serivceUpdate}$id',
      );
      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoadingWithCreate = false;
        notifyListeners();
        AppSnackBar.openErrorSnackBar(message: errorMessage);
        return;
      }

      isLoadingUpdate = false;
      notifyListeners();
      AppSnackBar.openSuccessSnackBar(
          message: 'Service Update Successfully'.tr);
      disposeAll();
      Get.offAllNamed(AppRoutes.bottomNavBar);
    } catch (error) {
      if (error is DioException) {
        AppSnackBar.openErrorSnackBar(
          message: Network().handelDioException(error),
        );
      } else {
        AppSnackBar.openErrorSnackBar(
          message: error.toString(),
        );
      }
      isLoadingUpdate = false;
      notifyListeners();
    }
  }

  onChangeCover(File? value) {
    cover = value;
    notifyListeners();
  }

  onChangeMedia(List<File> value) {
    media = value;
    notifyListeners();
  }

  onChangeSourceFile(bool? value) {
    sourceFile[planListUIndex] = value ?? false;
    notifyListeners();
  }

  Future<void> onChangeCategory(CategoryModel? value) async {
    categoryModel = value;
    notifyListeners();
    await getSubcategories(value?.id ?? 0);
  }

  Future<void> onChangeSubcategory(SubcategoryModel? value) async {
    subcategoryModel = value;
    await getTags();
    notifyListeners();
  }

  void onChangePlan(PlanModelData? value) {
    plan[planListUIndex] = value;
    notifyListeners();
  }

  void onSelectedCurrency(CurrencyModelData? value) {
    selectedCurrency = value;
    notifyListeners();
  }

  void onChangeTags(List<TagsModelData?> value) {
    tagsSlug = value.map((e) => e?.slug ?? '').toList();
    selectedTage = value;
    notifyListeners();
  }

  Future<void> getCategories() async {
    categories?.clear();
    isLoadingCategory = true;
    notifyListeners();
    final getCategoriesUseCase = GetCategoriesUseCase(
      homeRepository: sl(),
      url: AppEndpoints.freelancerCategories,
    );
    final result = await getCategoriesUseCase(null);
    result!.fold((l) {
      isLoadingCategory = false;
    }, (r) {
      isLoadingCategory = false;
      categories = r.data;
      notifyListeners();
    });
  }

  Future<void> getSubcategories(int id) async {
    isLoadingSubcategory = true;
    subcategories?.clear();
    notifyListeners();
    GetSubcategoriesUseCase getSubcategoriesUseCase = sl();
    final result = await getSubcategoriesUseCase(id);
    result!.fold((l) {
      isLoadingSubcategory = false;
    }, (r) {
      isLoadingSubcategory = false;
      subcategories = r.data ?? [];
      notifyListeners();
    });
  }

  getTags() async {
    try {
      tagsList?.clear();
      isLoadingTags = true;
      notifyListeners();
      final response = await Network().get(
        url: '${AppEndpoints.tags}${subcategoryModel?.id}',
      );

      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoadingTags = false;
        notifyListeners();
        AppSnackBar.openErrorSnackBar(message: errorMessage);
        return;
      }
      TagsModel tagsModel = TagsModel.fromJson(response.data);
      tagsList = tagsModel.data;
      isLoadingTags = false;
      notifyListeners();
    } catch (error) {
      if (error is DioException) {
        AppSnackBar.openErrorSnackBar(
          message: Network().handelDioException(error),
        );
      } else {
        AppSnackBar.openErrorSnackBar(
          message: error.toString(),
        );
      }
      isLoadingTags = false;
      notifyListeners();
    }
  }

  getPlans() async {
    try {
      planList?.clear();
      isLoadingPlan = true;
      notifyListeners();
      final response = await Network().get(
        url: AppEndpoints.plans,
      );

      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoadingTags = false;
        notifyListeners();
        AppSnackBar.openErrorSnackBar(message: errorMessage);
        return;
      }
      PlanModel pansModel = PlanModel.fromJson(response.data);
      planList = pansModel.data;
      isLoadingPlan = false;
      notifyListeners();
    } catch (error) {
      if (error is DioException) {
        AppSnackBar.openErrorSnackBar(
          message: Network().handelDioException(error),
        );
      } else {
        AppSnackBar.openErrorSnackBar(
          message: error.toString(),
        );
      }
      isLoadingPlan = false;
      notifyListeners();
    }
  }

  addPlanListUIndex() {
    if (plan[planListUIndex]?.id == null) {
      AppSnackBar.openErrorSnackBar(message: 'Please select a plan.'.tr);
      return;
    } else if (selectedCurrency == null) {
      AppSnackBar.openErrorSnackBar(message: 'Please select a currency.'.tr);
      return;
    }

    for (var data in plan) {
      planList?.removeWhere(
        (element) => element?.id == data?.id,
      );
      if (planList?.isEmpty == true) {
        AppSnackBar.openErrorSnackBar(
            message: 'A new plan cannot be added.'.tr);
        return;
      }
    }

    planListUIndex = planListUIndex + 1;
    listOfPlans.add(const PlanCard());
    priceController.add(TextEditingController());
    deliveryDayController.add(TextEditingController());
    revisionController.add(TextEditingController());
    plan.add(PlanModelData());
    //selectedCurrency.add(CurrencyModelData());
    sourceFile.add(false);
    notifyListeners();
  }

  removePlanAtIndex(int index) {
    if (index >= 0 && index < listOfPlans.length) {
      listOfPlans.removeAt(index);
      planListUIndex = listOfPlans.length - 1;
      priceController.removeAt(index);
      deliveryDayController.removeAt(index);
      revisionController.removeAt(index);
      if (plan[index]?.id != null && planList?.contains(plan[index]) == false) {
        planList?.add(plan[index]);
      }
      plan.removeAt(index);
      //selectedCurrency.removeAt(index);
      sourceFile.removeAt(index);
      notifyListeners();
    }
  }

  String? validateServiceData({
    required List<TextEditingController> deliveryDayController,
    required List<TextEditingController> priceController,
    required List<TextEditingController> revisionController,
    required List<PlanModelData?> plan,
  }) {
    if (plan.isEmpty || plan.any((e) => e == null)) {
      return "At least one plan must be selected.";
    }

    if (deliveryDayController
        .any((c) => c.text.isEmpty || int.tryParse(c.text) == null)) {
      return "Please enter valid delivery days.";
    }

    if (priceController
        .any((c) => c.text.isEmpty || double.tryParse(c.text) == null)) {
      return "Please enter valid prices.";
    }

    if (revisionController
        .any((c) => c.text.isEmpty || int.tryParse(c.text) == null)) {
      return "Please enter valid revision numbers.";
    }

    if (selectedCurrency == null) {
      return "Please select a currency.";
    }

    return null;
  }

  void disposeAll() {
    titleController.clear();
    //descriptionController.clear();
    quillController.dispose();
    cover = null;
    media.clear();
    categoryModel = null;
    subcategoryModel = null;
    tagsSlug.clear();
    selectedTage?.clear();
    tagsList?.clear();
    planListUIndex = 0;
    selectedCurrency = null;

    listOfPlans = [const PlanCard()];
    priceController = [TextEditingController()];
    deliveryDayController = [TextEditingController()];
    revisionController = [TextEditingController()];
    plan = [PlanModelData()];
    sourceFile = [false];
  }
}

import 'dart:io';

import 'package:dio/dio.dart';

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
  List<int> tagsId = [];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  File? cover;
  List<File> media = [];

  bool isLoadingCategory = false;
  bool isLoadingSubcategory = false;
  bool isLoadingTags = false;
  bool isLoadingPlan = false;

  ///LIST

  int planListUIndex = 0;
  final List<PlanCard> listOfPlans = [const PlanCard()];

  final List<TextEditingController> priceController = [TextEditingController()];
  final List<TextEditingController> deliveryDayController = [
    TextEditingController()
  ];
  final List<TextEditingController> revisionController = [
    TextEditingController()
  ];
  final List<PlanModelData?> plan = [PlanModelData()];
  final List<CurrencyModelData?> selectedCurrency = [CurrencyModelData()];
  final List<bool> sourceFile = [false];

  bool isLoadingWithCreate = false;

  createNewService() async {
    try {
      isLoadingWithCreate = true;
      notifyListeners();
      final error = validateServiceData(
        titleController: titleController,
        descriptionController: descriptionController,
        deliveryDayController: deliveryDayController,
        priceController: priceController,
        revisionController: revisionController,
        plan: plan,
        cover: cover,
        media: media,
        subcategoryModel: subcategoryModel,
      );

      if (error != null) {
        AppSnackBar.openErrorSnackBar(message: error);
        isLoadingWithCreate = false;
        notifyListeners();
        return;
      }

      var data = CreateServiceParam(
        title: titleController.text,
        cover: cover!,
        deliveryDays:
            deliveryDayController.map((e) => int.parse(e.text)).toList(),
        description: descriptionController.text,
        media: media,
        planId: plan.map((e) => e?.id ?? 0).toList(),
        price: priceController.map((e) => double.parse(e.text)).toList(),
        revision: revisionController.map((e) => int.parse(e.text)).toList(),
        sourceFile: sourceFile,
        supCategoryId: subcategoryModel?.id ?? 0,
        tags: tagsId,
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

  onChangeCategory(CategoryModel? value) {
    categoryModel = value;
    notifyListeners();
    getSubcategories(value?.id ?? 0);
  }

  onChangeSubcategory(SubcategoryModel? value) {
    subcategoryModel = value;
    notifyListeners();
  }

  onChangePlan(PlanModelData? value) {
    plan[planListUIndex] = value;
    notifyListeners();
  }

  onSelectedCurrency(CurrencyModelData? value) {
    selectedCurrency[planListUIndex] = value;
    notifyListeners();
  }

  onChangeTags(List<TagsModelData?> value) {
    tagsId = value.map((e) => e?.id ?? 0).toList();
    notifyListeners();
  }

  getCategories() async {
    categories?.clear();
    isLoadingCategory = true;
    notifyListeners();
    GetCategoriesUseCase getCategoriesUseCase = sl();
    final result = await getCategoriesUseCase(());
    result!.fold((l) {
      isLoadingCategory = false;
    }, (r) {
      isLoadingCategory = false;
      categories = r.data;
      notifyListeners();
    });
  }

  getSubcategories(int id) async {
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
        url: AppEndpoints.tags,
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
      if (selectedCurrency[planListUIndex] != null) {
        selectedCurrency[planListUIndex] = null;
      }
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

  allPlanListUIndex() {
    planListUIndex = planListUIndex + 1;
    listOfPlans.add(const PlanCard());
    priceController.add(TextEditingController());
    deliveryDayController.add(TextEditingController());
    revisionController.add(TextEditingController());
    plan.add(PlanModelData());
    selectedCurrency.add(CurrencyModelData());
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
      plan.removeAt(index);
      selectedCurrency.removeAt(index);
      sourceFile.removeAt(index);
      notifyListeners();
    }
  }

  String? validateServiceData({
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    required List<TextEditingController> deliveryDayController,
    required List<TextEditingController> priceController,
    required List<TextEditingController> revisionController,
    required List<PlanModelData?> plan,
    required File? cover,
    required List<File> media,
    required SubcategoryModel? subcategoryModel,
  }) {
    if (titleController.text.trim().isEmpty) return "Title is required.";
    if (descriptionController.text.trim().isEmpty) {
      return "Description is required.";
    }
    if (cover == null) return "Cover photo is required.";
    if (subcategoryModel == null || subcategoryModel.id == 0) {
      return "Subcategory is required.";
    }
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

    return null;
  }
}

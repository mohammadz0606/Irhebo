import 'package:dio/dio.dart';

import '../../../app/global_imports.dart';
import '../../../app/network/network.dart';
import '../../../presentation/screens/freelancer_services/widgets/plan_card.dart';
import '../../models/home_model.dart';
import '../../models/new_models/currency_model.dart';
import '../../models/new_models/plan_model.dart';
import '../../models/new_models/tags_model.dart';
import '../../usecases/home_usecases/get_categories_use_case.dart';
import '../../usecases/home_usecases/get_subcategories_use_case.dart';

class ServiceProvider extends ChangeNotifier {
  CategoryModel? categoryModel;
  List<CategoryModel>? categories;
  SubcategoryModel? subcategoryModel;
  List<SubcategoryModel>? subcategories;
  List<TagsModelData?>? tagsList;
  List<PlanModelData?>? planList;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

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
  PlanModelData? plan;
  CurrencyModelData? selectedCurrency;
  bool sourceFile = false;

  onChangeSourceFile(bool? value) {
    sourceFile = value ?? false;
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
    plan = value;
    notifyListeners();
  }

  onSelectedCurrency(CurrencyModelData? value) {
    selectedCurrency = value;
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
      if (selectedCurrency != null) {
        selectedCurrency = null;
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
    notifyListeners();
  }

  removePlanAtIndex(int index) {
    if (index >= 0 && index < listOfPlans.length) {
      listOfPlans.removeAt(index);
      planListUIndex = listOfPlans.length - 1;
      priceController.removeAt(index);
      deliveryDayController.removeAt(index);
      revisionController.removeAt(index);
      notifyListeners();
    }
  }
}

import 'package:dio/dio.dart';

import '../../../app/global_imports.dart';
import '../../../app/network/network.dart';
import '../../models/home_model.dart';
import '../../models/new_models/tags_model.dart';
import '../../usecases/home_usecases/get_categories_use_case.dart';
import '../../usecases/home_usecases/get_subcategories_use_case.dart';

class ServiceProvider extends ChangeNotifier {
  CategoryModel? categoryModel;
  List<CategoryModel>? categories;
  SubcategoryModel? subcategoryModel;
  List<SubcategoryModel>? subcategories;
  List<TagsModelData?>? tagsList;

  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();

  bool isLoadingCategory = false;
  bool isLoadingSubcategory = false;
  bool isLoadingTags = false;

  onChangeCategory(CategoryModel? value) {
    categoryModel = value;
    notifyListeners();
    getSubcategories(value?.id ?? 0);
  }

  onChangeSubcategory(SubcategoryModel? value) {
    subcategoryModel = value;
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
}

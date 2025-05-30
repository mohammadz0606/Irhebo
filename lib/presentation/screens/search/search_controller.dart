import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/constants.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/snack_bar.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/domain/params/pagination_params.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_categories_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_service_by_subcategory_id_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_service_by_tag_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_services_filters_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_subcategories_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/search_service_use_case.dart';
import 'package:irhebo/presentation/screens/search/widgets/filter/filter_bottom_sheet.dart';
import 'package:irhebo/presentation/screens/service_details/service_details_screen.dart';
import 'package:irhebo/presentation/widgets/app_dialog.dart';
import 'package:irhebo/presentation/widgets/login_required_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchControllerGetx extends GetxController {
  final appController = Get.find<AppController>();

  List<TextEditingController> numbers = <TextEditingController>[];

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  Timer? _debounce;

  final GlobalKey<FormState> searchFormKey = GlobalKey<FormState>();
  PageController controller = PageController(initialPage: 0);
  TextEditingController searchController = TextEditingController();
  TextEditingController minSliderController = TextEditingController();
  TextEditingController maxSliderController = TextEditingController();

  final RxList<CategoryModel> _categories = <CategoryModel>[].obs;
  final RxList<SubcategoryModel> _subcategories = <SubcategoryModel>[].obs;
  final RxList<FilterModel> _multiDropDownButtonsFilters = <FilterModel>[].obs;
  // final RxList<FilterModel> _dropDownButtonsFilters = <FilterModel>[].obs;
  final RxList<CategoryModel> _filteredCategories = <CategoryModel>[].obs;
  final RxList<SubcategoryModel> _filteredSubcategories =
      <SubcategoryModel>[].obs;

  final RxList<FilterModel> _checkboxFilters = <FilterModel>[].obs;
  final RxList<FilterModel> _ratingFilters = <FilterModel>[].obs;
  final RxList<FilterModel> _rangeFilters = <FilterModel>[].obs;

  RxInt _pageNumber = 1.obs;
  final RxInt _pageIndex = 0.obs;
  final RxInt _selectedType = (0).obs;
  final RxString _appBarTitle = "".obs;
  final RxBool _isLoadingCategory = false.obs;
  final RxBool _isLoadingFilters = false.obs;
  final RxBool _isLoadingTag = false.obs;
  final RxBool _isLoadingSubcategory = false.obs;
  final RxBool _isLoadingService = false.obs;
  RxDouble _selectedMin = 1.0.obs;
  RxDouble _selectedMax = 499.0.obs;
  RangeValues sliderRange = RangeValues(0, 500);
  final RxList<ServiceModel> _services = <ServiceModel>[].obs;
  final RxList<TagModel> _tags = <TagModel>[].obs;

  int get pageNumber => _pageNumber.value;
  int get selectedType => _selectedType.value;
  String get appBarTitle => _appBarTitle.value;
  int get pageIndex => _pageIndex.value;
  bool get isLoadingCategory => _isLoadingCategory.value;
  bool get isLoadingFilters => _isLoadingFilters.value;
  bool get isLoadingTag => _isLoadingTag.value;
  bool get isLoadingSubcategory => _isLoadingSubcategory.value;
  bool get isLoadingService => _isLoadingService.value;
  List<ServiceModel> get services => _services;
  List<FilterModel> get multiDropDownButtonsFilters =>
      _multiDropDownButtonsFilters;
  // List<FilterModel> get dropDownButtonsFilters => _dropDownButtonsFilters;
  List<FilterModel> get checkboxFilters => _checkboxFilters;
  List<FilterModel> get rangeFilters => _rangeFilters;
  List<FilterModel> get ratingFilters => _ratingFilters;
  List<TagModel> get tags => _tags;
  double get selectedMin => _selectedMin.value;
  double get selectedMax => _selectedMax.value;
  List<CategoryModel> get categories => _filteredCategories;
  List<SubcategoryModel> get subcategories => _filteredSubcategories;

  set pageNumber(value) => _pageNumber.value = value;
  set categories(value) => _categories.value = value;
  set subcategories(value) => _subcategories.value = value;
  set selectedMin(value) => _selectedMin.value = value;
  set selectedMax(value) => _selectedMax.value = value;
  set selectedType(value) => _selectedType.value = value;
  set appBarTitle(value) => _appBarTitle.value = value;
  set pageIndex(value) => _pageIndex.value = value;
  set isLoadingCategory(value) => _isLoadingCategory.value = value;
  set isLoadingFilters(value) => _isLoadingFilters.value = value;
  set isLoadingTag(value) => _isLoadingTag.value = value;
  set isLoadingSubcategory(value) => _isLoadingSubcategory.value = value;
  set isLoadingService(value) => _isLoadingService.value = value;
  set services(value) => _services.value = value;
  set multiDropDownButtonsFilters(value) =>
      _multiDropDownButtonsFilters.value = value;
  // set dropDownButtonsFilters(value) => _dropDownButtonsFilters.value = value;
  set checkboxFilters(value) => _checkboxFilters.value = value;
  set rangeFilters(value) => _rangeFilters.value = value;
  set ratingFilters(value) => _ratingFilters.value = value;
  set tags(value) => _tags.value = value;

  List<FilterModel> numbersFilters = [];
  List<FilterModel> dropDownButtonsFilters = [];
  // List<SubcategoryModel> subcategories = [];
  String subccategoryTitle = "";
  bool fromCategories = false;
  int categoryId = 0;
  int subcategoryId = 0;

  var selectedMultiDropdownItems = <int, List<FilterOptionModel?>>{}.obs;

  var selectedDropdownItems = <int, FilterOptionModel?>{}.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    receiveParams();

    if (fromCategories == true) {
      controller = PageController(initialPage: 1);
      _pageIndex(1);
      getSubcategories(categoryId);
    } else {
      getCategories();
    }
    searchController.addListener(() {
      if (pageIndex == 0) {
        filterCategories(searchController.text);
      } else if (pageIndex == 1) {
        filterSubcategories(searchController.text);
      }
    });
  }

  void filterCategories(String query) {
    if (query.isEmpty) {
      _filteredCategories.value = _categories;
    } else {
      _filteredCategories.value = _categories
          .where((category) =>
              category.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void filterSubcategories(String query) {
    if (query.isEmpty) {
      _filteredSubcategories.value = _subcategories;
    } else {
      _filteredSubcategories.value = _subcategories
          .where((subcategory) =>
              subcategory.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  receiveParams() {
    if (Get.arguments != null) {
      fromCategories = Get.arguments["from_category"] ?? false;
      categoryId = Get.arguments["category_id"] ?? 0;
      appBarTitle = Get.arguments["title"] ?? "";
      subccategoryTitle = appBarTitle;
    }
    if (!fromCategories) {
      appBarTitle = "Categories";
    }
  }

  void onConfirmDropdown(
    List<FilterOptionModel?> selected,
    int filterId,
  ) {
    selectedMultiDropdownItems[filterId] = selected;
    selectedMultiDropdownItems.refresh();
    _multiDropDownButtonsFilters.refresh();
  }

  void onDropdownChange(int filterId, FilterOptionModel? selected) {
    selectedDropdownItems[filterId] = selected;
    selectedDropdownItems.refresh();
  }

  onChangeHandler(value) {
    const duration = Duration(milliseconds: 800);
    if (_debounce != null) {
      _debounce!.cancel();
    }
    _debounce = Timer(duration, () async {
      if (pageIndex == 2) {
        if (searchController.text.length >= 3) {
          pageNumber = 1;
          services.clear();
          await searchService(value);
        } else {
          AppSnackBar.openErrorSnackBar(
              message: "please enter three characters at least");
        }
      }
    });
  }

  onPageChanged(int index) {
    pageIndex = index;
  }

  Future<bool> onTapBack() {
    if (pageIndex == 0) {
      Get.back();
      return Future.value(true);
    } else {
      if (pageIndex == 1) {
        if (fromCategories) {
          Get.back();
        } else {
          searchController.clear();
          appBarTitle = "Categories";
        }
      } else {
        searchController.clear();
        services.clear();
        appBarTitle = subccategoryTitle;
      }
      controller.animateToPage(pageIndex - 1,
          duration: const Duration(milliseconds: 250), curve: Curves.linear);
      pageIndex = pageIndex - 1;
    }
    return Future.value(false);
  }

  onTapCategory(int index) async {
    appBarTitle = categories[index].title;
    subccategoryTitle = categories[index].title ?? "";
    controller.animateToPage(pageIndex + 1,
        duration: const Duration(milliseconds: 250), curve: Curves.linear);
    categoryId = categories[index].id ?? 0;
    searchController.clear();
    await getSubcategories(categoryId);
  }

  onTapTag(int index) async {
    pageNumber = 1;
    services.clear();
    selectedType = index;
    if (index == 0) {
      isLoadingService = true;
      await getServiceBySubcategoryId();
      isLoadingService = false;
    } else {
      getServiceByTag();
    }
  }

  onTapSubCategory(int index) async {
    appBarTitle = subcategories[index].title;
    controller.animateToPage(pageIndex + 1,
        duration: const Duration(milliseconds: 250), curve: Curves.linear);
    subcategoryId = subcategories[index].id ?? 0;
    searchController.clear();
    log("jnkjnjknjk");
    getPaginatedServicesById();
  }

  getPaginatedServicesById() async {
    clearData();
    isLoadingTag = true;
    isLoadingService = true;
    getServicesFilters();
    await getServiceBySubcategoryId();
    isLoadingTag = false;
    isLoadingService = false;
  }

  onLikeService(int index) async {
    if (appController.token.isEmpty) {
      openLoginRequiredDialog();
    } else {
      services[index].isWishlist = !services[index].isWishlist!;
      _services.refresh();
      bool result = await appController.addToWishlist(services[index].id);
      if (!result) {
        services[index].isWishlist = !services[index].isWishlist!;
        _services.refresh();
      }
    }
  }

  onTapService(int i) {
    Get.to(() => ServiceDetailsScreen(), arguments: {"id": services[i].id});
    // preventDuplicates: false,
  }

  onChangeMinField(newValue) {
    if (newValue >= sliderRange.start &&
        newValue <= sliderRange.end &&
        newValue <= selectedMax) {
      selectedMin = newValue;
    }
    if (newValue < sliderRange.start ||
        newValue > sliderRange.end ||
        newValue > selectedMax) {
      selectedMin = selectedMin;
      minSliderController.text = '${selectedMin.toInt()}';
    }
  }

  onLoadingServices() async {
    if (selectedType == 0) {
      searchController.clear();
      await getServiceBySubcategoryId();
    }
    if (searchController.text.isNotEmpty) {
      searchService(searchController.text);
    } else {
      searchController.clear();
      getServiceByTag();
    }
  }

  onChangeMaxField(newValue) {
    if (newValue >= sliderRange.start &&
        newValue <= sliderRange.end &&
        newValue >= selectedMin) {
      selectedMax = newValue;
    }
    if (newValue < sliderRange.start ||
        newValue > sliderRange.end ||
        newValue < selectedMin) {
      selectedMax = selectedMax;
      maxSliderController.text = '${selectedMax.toInt()}';
    }
  }

  openFilterBottomSheet() {
    selectedMin = sliderRange.start;
    selectedMax = sliderRange.end;
    minSliderController.text = '${sliderRange.start.toInt()}';
    maxSliderController.text = '${sliderRange.end.toInt()}';

    if (Get.context != null && Get.context!.mounted) {
      Get.bottomSheet(
        FilterBottomSheet(),
        backgroundColor: Get.find<AppController>().darkMode
            ? AppDarkColors.darkScaffoldColor
            : AppLightColors.pureWhite,
        barrierColor: Get.find<AppController>().darkMode
            ? AppDarkColors.darkContainer.withOpacity(0.3)
            : AppLightColors.shadow.withOpacity(0.3),
        elevation: 0,
        isScrollControlled: true,
      );
    }
  }

  onRate(int rate, int index) {
    if (ratingFilters[index].rateValue == rate) {
      ratingFilters[index].rateValue = ratingFilters[index].rateValue! - 1;
    } else {
      ratingFilters[index].rateValue = rate;
    }
    _ratingFilters.refresh();
  }

  changeBudgetRange(RangeValues range) {
    selectedMin = range.start;
    selectedMax = range.end;
    minSliderController.text = '${range.start.toInt()}';
    maxSliderController.text = '${range.end.toInt()}';
  }

  onPressCheckbox(int index, bool? val) {
    if (val != null) {
      checkboxFilters[index].checked =
          !checkboxFilters[index].checked; // Update RxBool value
    }
    _checkboxFilters.refresh();
  }

  getCategories() async {
    isLoadingCategory = true;
    GetCategoriesUseCase getCategoriesUseCase = sl();
    final result = await getCategoriesUseCase(());
    result!.fold((l) {
      isLoadingCategory = false;
    }, (r) {
      isLoadingCategory = false;
      categories = r.data;
      _categories.refresh();
      _filteredCategories.value = r.data ?? [];
    });
  }

  getSubcategories(int id) async {
    isLoadingSubcategory = true;
    GetSubcategoriesUseCase getSubcategoriesUseCase = sl();
    final result = await getSubcategoriesUseCase(id);
    result!.fold((l) {
      isLoadingSubcategory = false;
    }, (r) {
      isLoadingSubcategory = false;
      subcategories = r.data ?? [];
      _subcategories.refresh();
      _filteredSubcategories.value = r.data ?? [];
    });
  }

  onRefreshList() async {
    clearData();
    clearFilterData();
    getServicesFilters();
    await getServiceBySubcategoryId();
    refreshController.refreshCompleted();
    refreshController.refreshToIdle();
  }

  clearData() {
    searchController.clear();
    selectedType = 0;
    pageNumber = 1;
    services.clear();
    tags.clear();
  }

  getServiceBySubcategoryId() async {
    GetServiceBySubcategoryIdUseCase getServiceBySubcategoryIdUseCase = sl();
    final result = await getServiceBySubcategoryIdUseCase(PaginationParams(
        id: subcategoryId,
        page: pageNumber,
        perPage: AppConstants.PAGE_LENGTH));
    result!.fold((l) {
      refreshController.refreshFailed();
    }, (r) {
      if (pageNumber == 1) {
        tags.clear();
        tags.add(TagModel(slug: "all", title: "All".tr));
        tags.addAll(r.data?.tags ?? []);
        if (r.data!.tags!.isEmpty) {
          tags.clear();
        }
        _tags.refresh();
      }
      pageNumber = pageNumber + 1;
      services.addAll(r.data!.services ?? []);
      if (r.data!.services!.isEmpty) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      _services.refresh();
    });
  }

  searchService(String query) async {
    if (pageNumber == 1) {
      isLoadingService = true;
    }
    selectedType = 0;
    SearchServiceUseCase searchServiceUseCase = sl();
    final result = await searchServiceUseCase(PaginationParams(
        query: query, page: pageNumber, perPage: AppConstants.PAGE_LENGTH));
    result!.fold((l) {
      if (pageNumber == 1) {
        isLoadingService = true;
      }
      refreshController.refreshFailed();
    }, (r) {
      if (pageNumber == 1) {
        isLoadingService = false;
      }
      pageNumber = pageNumber + 1;
      services.addAll(r.data!.services ?? []);
      if (r.data!.services!.isEmpty) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      _services.refresh();
    });
  }

  getServiceByTag() async {
    if (pageNumber == 1) {
      isLoadingService = true;
    }
    GetServiceByTagUseCase getServiceByTagUseCase = sl();
    final result = await getServiceByTagUseCase(PaginationParams(
        tag: tags[selectedType].slug ?? "",
        page: pageNumber,
        perPage: AppConstants.PAGE_LENGTH));
    result!.fold((l) {
      if (pageNumber == 1) {
        isLoadingService = false;
      }
      refreshController.refreshFailed();
    }, (r) {
      if (pageNumber == 1) {
        isLoadingService = false;
      }
      pageNumber = pageNumber + 1;
      services.addAll(r.data!.services ?? []);
      if (r.data!.services!.isEmpty) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      _services.refresh();
    });
  }

  getServicesFilters() async {
    numbers = [];
    isLoadingFilters = true;
    GetServicesFiltersUseCase getServicesFiltersUseCase = sl();
    final result = await getServicesFiltersUseCase(categoryId);
    result!.fold((l) {
      isLoadingFilters = false;
    }, (r) {
      checkboxFilters =
          r.data!.where((filter) => filter.type == "checkbox").toList();
      _checkboxFilters.refresh();
      ratingFilters =
          r.data!.where((filter) => filter.type == "rating").toList();
      _ratingFilters.refresh();
      // rangeFilters = r.data!.where((filter) => filter.type == "range").toList();
      // _rangeFilters.refresh();
      numbersFilters =
          (r.data!.where((filter) => filter.type == "number").toList());
      numbersFilters.forEach(
        (element) => numbers.add(TextEditingController()),
      );
      dropDownButtonsFilters =
          (r.data!.where((filter) => filter.type == "dropdown").toList());
      multiDropDownButtonsFilters = (r.data!
          .where((filter) => filter.type == "dropdown_multiple")
          .toList());
      _multiDropDownButtonsFilters.refresh();
      isLoadingFilters = false;
    });
  }

  resetFilter() {
    checkboxFilters.forEach(
      (element) => element.checked = false,
    );
    _checkboxFilters.refresh();
    ratingFilters.forEach(
      (element) => element.rateValue = 0,
    );
    _ratingFilters.refresh();
    numbers.forEach(
      (element) => element.clear(),
    );
    selectedDropdownItems.clear();
    selectedMultiDropdownItems.clear();
  }

  clearFilterData() {
    checkboxFilters.clear();
    ratingFilters.clear();
    numbers.clear();
    numbersFilters.clear();
    dropDownButtonsFilters.clear();
    multiDropDownButtonsFilters.clear();
    selectedDropdownItems.clear();
    selectedMultiDropdownItems.clear();
  }

  openLoginRequiredDialog() {
    Get.dialog(
      barrierColor: Get.find<AppController>().darkMode
          ? AppDarkColors.darkContainer.withOpacity(0.3)
          : AppLightColors.shadow.withOpacity(0.3),
      AppDialog(
        child: LoginRequiredDialog(),
      ),
    );
  }

  applyFilter() async {
    isLoadingService = true;
    services.clear();
    await Future.delayed(Duration(seconds: 4));
    // await onRefreshList();
    Get.back();

    isLoadingService = false;
  }
}

import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/constants.dart';
import 'package:irhebo/app/global_imports.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/network/network.dart';
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

import '../../../domain/models/login_model.dart';
import '../../../domain/models/new_models/search/new_search_model.dart';

class SearchControllerGetx extends GetxController {
  final appController = Get.find<AppController>();

  List<TextEditingController> numbers = <TextEditingController>[];

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  Timer? _debounce;

  final GlobalKey<FormState> searchFormKey = GlobalKey<FormState>();
  PageController controller = PageController(initialPage: 0);
  TextEditingController searchController = TextEditingController();
  final RxString searchText = ''.obs;

  TextEditingController minSliderController = TextEditingController();
  TextEditingController maxSliderController = TextEditingController();

  final RxList<CategoryModel> _categories = <CategoryModel>[].obs;
  final Rx<NewSearchModel> _newSearchModel = NewSearchModel().obs;
  final RxList<SubcategoryModel> _subcategories = <SubcategoryModel>[].obs;
  final RxList<FilterModel> _multiDropDownButtonsFilters = <FilterModel>[].obs;

  // final RxList<FilterModel> _dropDownButtonsFilters = <FilterModel>[].obs;
  final RxList<CategoryModel> _filteredCategories = <CategoryModel>[].obs;
  final RxList<CategoryModel> _categoriesSearch = <CategoryModel>[].obs;
  final RxList<SubcategoryModel> _filteredSubcategories =
      <SubcategoryModel>[].obs;
  final RxList<SubcategoryModel> _searchSubcategories =
      <SubcategoryModel>[].obs;

  final RxList<FilterModel> _checkboxFilters = <FilterModel>[].obs;
  final RxList<FilterModel> _ratingFilters = <FilterModel>[].obs;
  final RxList<FilterModel> _rangeFilters = <FilterModel>[].obs;

  final RxInt _pageNumber = 1.obs;
  final RxInt _pageIndex = 0.obs;
  final RxInt _selectedType = (0).obs;
  final RxString _appBarTitle = "".obs;
  final RxBool _isLoadingSubCategoryNew = false.obs;
  final RxBool _isLoadingCategory = false.obs;
  final RxBool _isLoadingFilters = false.obs;
  final RxBool _isLoadingTag = false.obs;
  final RxBool _isLoadingSubcategory = false.obs;
  final RxBool _isLoadingService = false.obs;
  final RxDouble _selectedMin = 1.0.obs;
  final RxDouble _selectedMax = 499.0.obs;
  RangeValues sliderRange = const RangeValues(0, 500);
  final RxList<ServiceModel> _services = <ServiceModel>[].obs;
  final RxList<ServiceModel> _servicesSearch = <ServiceModel>[].obs;
  final RxList<TagModel> _tags = <TagModel>[].obs;

  int get pageNumber => _pageNumber.value;

  int get selectedType => _selectedType.value;

  String get appBarTitle => _appBarTitle.value;

  int get pageIndex => _pageIndex.value;

  bool get isLoadingSubcategoriesNew => _isLoadingSubCategoryNew.value;

  bool get isLoadingCategory => _isLoadingCategory.value;

  bool get isLoadingFilters => _isLoadingFilters.value;

  bool get isLoadingTag => _isLoadingTag.value;

  bool get isLoadingSubcategory => _isLoadingSubcategory.value;

  bool get isLoadingService => _isLoadingService.value;

  List<ServiceModel> get services => _services;

  List<ServiceModel> get servicesSearch => _servicesSearch;

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

  List<CategoryModel> get categoriesSearch => _categoriesSearch;

  NewSearchModel get searchModel => _newSearchModel.value;

  List<SubcategoryModel> get subcategories => _filteredSubcategories;

  List<SubcategoryModel> get searchSubcategories => _searchSubcategories;

  set pageNumber(value) => _pageNumber.value = value;

  set categories(value) => _categories.value = value;

  set searchModel(value) => _newSearchModel.value = value;

  set subcategories(value) => _subcategories.value = value;

  set selectedMin(value) => _selectedMin.value = value;

  set selectedMax(value) => _selectedMax.value = value;

  set selectedType(value) => _selectedType.value = value;

  set appBarTitle(value) => _appBarTitle.value = value;

  set pageIndex(value) => _pageIndex.value = value;

  set isLoadingSubcategoriesNew(value) =>
      _isLoadingSubCategoryNew.value = value;

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
  bool isSeeAll = false;
  int categoryId = 0;
  int subcategoryId = 0;

  var selectedMultiDropdownItems = <int, List<FilterOptionModel?>>{}.obs;

  var selectedDropdownItems = <int, FilterOptionModel?>{}.obs;

  /// NEW VALUES

  TextEditingController searchFilterController = TextEditingController();
  RangeValues priceRange = const RangeValues(1, 1000);
  RangeValues revisionsRange = const RangeValues(1, 10);
  RangeValues deliveryDayRange = const RangeValues(1, 180);
  RxBool sourceFile = false.obs;

  void onChangeSourceFile(bool? value) {
    sourceFile.value = value ?? false;
  }

  onChangePriceRange(RangeValues values) {
    priceRange = values;
  }

  onChangeRevisionsRange(RangeValues values) {
    revisionsRange = values;
  }

  onChangeDeliveryDayRange(RangeValues values) {
    deliveryDayRange = values;
  }

  resetFilter() async {
    Navigator.pop(Get.context!);
    searchFilterController.clear();
    priceRange = const RangeValues(1, 1000);
    revisionsRange = const RangeValues(1, 10);
    deliveryDayRange = const RangeValues(1, 180);
    sourceFile.value = false;
    await getPaginatedServicesById();
  }

  applyFilter() async {
    try {
      isLoadingService = true;
      services.clear();
      AppPreferences pref = sl();
      final response = await Network().post(
        url: AppEndpoints.applyFilter,
        data: {
          'currency': pref.getString(key: AppPrefsKeys.CURRENCY) ?? 'USD',
          'search': searchController.text.trim(),
          'filters': [
            {
              "filter_type": "price", // price
              "min": priceRange.start.toInt(),
              "max": priceRange.end.toInt(),
            },
            {
              "filter_type": "revisions", // price
              "min": revisionsRange.start.toInt(),
              "max": revisionsRange.end.toInt(),
            },
            {
              "filter_type": "delivery_days", // price
              "min": deliveryDayRange.start.toInt(),
              "max": deliveryDayRange.end.toInt(),
            },
            {
              "source_files": sourceFile.value,
            }
          ],
        },
      );
      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoadingService = false;
        AppSnackBar.openErrorSnackBar(message: errorMessage);
        return;
      }

      services = (response.data['data'] as List<dynamic>?)
          ?.map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList();
      isLoadingService = false;
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

      isLoadingService = false;
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    searchFilterController.clear();
    priceRange = const RangeValues(1, 1000);
    revisionsRange = const RangeValues(1, 10);
    deliveryDayRange = const RangeValues(1, 180);
    sourceFile.value = false;
    receiveParams();
    getCategory();
    if (fromCategories == true) {
      controller = PageController(initialPage: 3);
      _pageIndex(3);
      getSubcategories(categoryId);
    } else if (isSeeAll) {
      controller = PageController(initialPage: 2);
      _pageIndex(2);
    } else {
      getSubcategoriesAndServicesNew();
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
      isSeeAll = Get.arguments['is_see_all'] ?? false;
      subccategoryTitle = appBarTitle;
    }
    if (!fromCategories) {
      appBarTitle = "Search".tr;
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

  onChangeHandler(value) async {
    searchText.value = value;
    if (pageIndex == 0) {
      await getSubcategoriesAndServicesNew(text: searchController.text.trim());
    } else if (pageIndex == 1) {
      final searchText = value.trim().toLowerCase();
      final data = services.where((service) {
        final name = service.title?.toLowerCase() ?? '';
        return name.contains(searchText);
      }).toList();
      _servicesSearch.value = data;
    } else if (pageIndex == 2) {
      final searchText = value.trim().toLowerCase();
      final data = categories.where((category) {
        final name = category.title?.toLowerCase() ?? '';
        return name.contains(searchText);
      }).toList();
      _categoriesSearch.value = data;
    } else if (pageIndex == 3) {
      final searchText = value.trim().toLowerCase();
      final data = subcategories.where((subcategory) {
        final name = subcategory.title?.toLowerCase() ?? '';
        return name.contains(searchText);
      }).toList();
      _searchSubcategories.value = data;
    }
  }

// const duration = Duration(milliseconds: 800);
  // if (_debounce != null) {
  //   _debounce!.cancel();
  // }
  // _debounce = Timer(
  //   duration,
  //   () async {
  //     if (pageIndex == 2) {
  //       if (searchController.text.length >= 3) {
  //         pageNumber = 1;
  //         services.clear();
  //         await searchService(value);
  //       } else {
  //         AppSnackBar.openErrorSnackBar(
  //             message: "please enter three characters at least");
  //       }
  //     }
  //   },
  // );
  onPageChanged(int index) {
    pageIndex = index;
  }

  Future<bool> onTapBack() {
    if (pageIndex == 0 || pageIndex == 2) {
      Get.back();
      return Future.value(true);
    } else {
      if (pageIndex == 1) {
        if (fromCategories) {
          //Get.back();
        } else {
          searchController.clear();
          searchText.value = '';
          appBarTitle = "Categories";
        }
      } else {
        searchController.clear();
        searchText.value = '';
        services.clear();
        appBarTitle = subccategoryTitle;
        if (!isSeeAll) {
          Get.back();
        }
      }
      if (fromCategories && !isSeeAll) {
        controller.jumpToPage(3);
        pageIndex = 3;
      } else if (isSeeAll && pageIndex == 1) {
        controller.jumpToPage(3);
        pageIndex = 3;
      } else if (isSeeAll && pageIndex == 3) {
        controller.jumpToPage(2);
        pageIndex = 2;
      } else {
        controller.animateToPage(pageIndex - 1,
            duration: const Duration(milliseconds: 250), curve: Curves.linear);
        pageIndex = pageIndex - 1;
      }
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
    searchText.value = '';
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

  onTapSubCategory(int index, {required int pageIndex}) async {
    //appBarTitle = subcategories[index].title;
    if (searchModel.data?.subCategories == null) {
      appBarTitle = subcategories[index].title;
      subcategoryId = subcategories[index].id ?? 0;
    } else {
      appBarTitle = searchModel.data?.subCategories?[index]?.title;
      subcategoryId = searchModel.data?.subCategories?[index]?.id ?? 0;
    }
    // controller.animateToPage(1,
    //     duration: const Duration(milliseconds: 250), curve: Curves.linear);
    //subcategoryId = subcategories[index].id ?? 0;
    searchController.clear();
    searchText.value = '';
    controller.jumpToPage(1);
    log("jnkjnjknjk");
    getPaginatedServicesById();
  }

  getPaginatedServicesById() async {
    clearData();
    isLoadingTag = true;
    isLoadingService = true;
    //getServicesFilters();
    await getServiceBySubcategoryId();
    isLoadingTag = false;
    isLoadingService = false;
  }

  onLikeService(int index) async {
    if (appController.token.isEmpty) {
      openLoginRequiredDialog();
    } else {
      services[index].isWishlist = !services[index].isWishlist!;
      _newSearchModel.value.data?.services?[index]?.isWishlist =
          !_newSearchModel.value.data!.services![index]!.isWishlist!;
      _services.refresh();
      _newSearchModel.refresh();
      bool result = await appController.addToWishlist(services[index].id);
      if (!result) {
        services[index].isWishlist = !services[index].isWishlist!;
        _newSearchModel.value.data?.services?[index]?.isWishlist =
            !_newSearchModel.value.data!.services![index]!.isWishlist!;
        _services.refresh();
        _newSearchModel.refresh();
      }
    }
  }

  onTapService(int i) {
    Get.to(() => const ServiceDetailsScreen(),
        arguments: {"id": services[i].id});
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
      searchText.value = '';

      await getServiceBySubcategoryId();
    }
    if (searchController.text.isNotEmpty) {
      searchService(searchController.text);
    } else {
      searchController.clear();
      searchText.value = '';

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
        const FilterBottomSheet(),
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

  Future<void> getSubcategoriesAndServicesNew({String text = ''}) async {
    try {
      _newSearchModel.refresh();
      _services.refresh();
      isLoadingSubcategoriesNew = true;

      final response = await Network().get(url: AppEndpoints.newSearch, query: {
        'perPage': 100,
        'search': text,
      });
      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoadingSubcategoriesNew = false;
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        return;
      }

      searchModel = NewSearchModel.fromJson(response.data);

      services = searchModel.data?.services?.map(
        (e) {
          return ServiceModel(
            id: e?.id,
            title: e?.title,
            cover: e?.cover,
            description: e?.description,
            isRecommended: e?.isRecommended,
            isWishlist: e?.isWishlist,
            rating: e?.rating,
            startServiceFrom: e?.startServiceFrom,
            subCategoryId: e?.subCategoryId,
            user: UserModel(
              id: e?.user?.id,
              username: e?.user?.username,
              name: e?.user?.username,
              profession: e?.user?.profession,
              avatar: e?.user?.avatar,
            ),
          );
        },
      ).toList();
      //categories
      isLoadingSubcategoriesNew = false;
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
      isLoadingSubcategoriesNew = false;
    }

    //?perPage=100&search=
    // GetCategoriesUseCase getCategoriesUseCase = sl();
    // final result = await getCategoriesUseCase(());
    // result!.fold((l) {
    //   isLoadingCategory = false;
    // }, (r) {
    //   isLoadingCategory = false;
    //   categories = r.data;
    //   _categories.refresh();
    //   _filteredCategories.value = r.data ?? [];
    // });
  }

  Future<void> getCategory() async {
    //?perPage=100&search=
    isLoadingCategory = true;
    _categoriesSearch.clear();
    GetCategoriesUseCase getCategoriesUseCase = sl();
    final result = await getCategoriesUseCase(());
    result!.fold((l) {
      isLoadingCategory = false;
    }, (r) {
      isLoadingCategory = false;
      categories = r.data;
      _categoriesSearch.value = r.data ?? [];
      _categories.refresh();
      _categoriesSearch.refresh();
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
      _searchSubcategories.refresh();
      _filteredSubcategories.value = r.data ?? [];
      _searchSubcategories.value = r.data ?? [];
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
    searchText.value = '';
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
      _servicesSearch.refresh();
      _servicesSearch.value = services;
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
      const AppDialog(
        child: LoginRequiredDialog(),
      ),
    );
  }
}

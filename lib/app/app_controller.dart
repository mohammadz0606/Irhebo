// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';
import 'dart:ui';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/constants.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/lang/localization_service.dart';
import 'package:irhebo/app/resources/logger_colors.dart';
import 'package:irhebo/app/storage/app_prefs.dart';
import 'package:irhebo/app/storage/app_prefs_keys.dart';
import 'package:irhebo/domain/entities/gender_entity.dart';
import 'package:irhebo/domain/models/config_model.dart';
import 'package:irhebo/domain/models/general_model.dart';
import 'package:irhebo/domain/usecases/home_usecases/toggle_fav_use_case.dart';
import 'package:irhebo/domain/usecases/intro_usecases/get_config_use_case.dart';
import 'package:irhebo/domain/usecases/intro_usecases/get_general_use_case.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:url_launcher/url_launcher.dart';

import '../domain/models/new_models/new_config_model.dart';
import 'enums.dart';
import 'network/end_points.dart';
import 'network/network.dart';

class AppController extends GetxController {
  late Rx<Locale> lang;
  final Rx<bool> _darkMode = true.obs;
  final List<String> items = [
    "English",
    "العربية",
  ];

  bool get darkMode => _darkMode.value;

  set darkMode(value) => _darkMode.value = value;

  String token = '';
  bool? steps;

  String countryCode = '+966';
  GeneralModel? generalData;
  AppPreferences prefs = sl();

  List<NewConfigModelDataProfessions?> professions = [];
  List<NewConfigModelDataCountries?> countries = [];
  List<NewConfigModelDataLanguagesData?> languages = [];

  List<GenderEntity> genders = [
    GenderEntity("1", "male"),
    GenderEntity("2", "female"),
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    await detectLanguageLocale();
    await detectAppTheme();
    token = prefs.getAccessToken();
    getConfig();
    log("${AppLoggerColors.magenta}${token}token");
  }

  final botKey = GlobalKey();
  final searchKey = GlobalKey();
  final whatsappKey = GlobalKey();
  final serviceKey = GlobalKey();
  final porfolioKey = GlobalKey();
  final porfolioFreelancerKey = GlobalKey();
  final chatKey = GlobalKey();
  final notificationsKey = GlobalKey();
  final categoriesKey = GlobalKey();
  final requestFreelancer = GlobalKey();
  final serviceFreelancer = GlobalKey();

  showCaseView(context) {
    bool showcaseHomeKey = getBoolValue(AppPrefsKeys.SHOW_CASE_HOME);
    if (!showcaseHomeKey) {
      ShowCaseWidget.of(context).startShowCase([
        chatKey,
        botKey,
        searchKey,
        whatsappKey,
        notificationsKey,
        categoriesKey,
        serviceKey,
        porfolioKey,
        requestFreelancer,
        serviceFreelancer,
        porfolioFreelancerKey,
      ]);
    }
  }

  detectAppTheme() {
    darkMode = prefs.getThemeValue(AppPrefsKeys.DARK);
    onChangeThemeMode(darkMode);
  }

  getConfig() async {
    // GetConfigUseCase getConfigUseCase = sl();
    // final result = await getConfigUseCase(());
    // result!.fold((l) {}, (r) {
    //   professions = r.data!.professions ?? [];
    //   countries = r.data!.countries!.data ?? [];
    //   languages = r.data!.languages!.data ?? [];
    // });
    final response = await Network().get(url: AppEndpoints.config);

    NewConfigModel configModel = NewConfigModel.fromJson(response.data);
    professions = configModel.data?.professions ?? [];
    countries = configModel.data?.countries ?? [];
    languages = configModel.data?.languages?.data ?? [];
  }

  detectLanguageLocale() async {
    String langCode = await getAppLanguage();
    log('${AppLoggerColors.magenta} LANGUAGE CODE : $langCode');
    if (langCode == AppLanguage.en.name) {
      lang = AppConstants.englishLocale.obs;
    } else {
      lang = AppConstants.arabicLocale.obs;
    }
  }

  Future<bool> addToWishlist(id) async {
    ToggleFavUseCase toggleFavUseCase = sl();
    final result = await toggleFavUseCase(id);
    return result!.fold((l) {
      return false;
    }, (r) {
      return true;
    });
  }

  onChangeCountryCode(CountryCode value) {
    countryCode = value.dialCode ?? "";
    log(countryCode.toString());
  }

  Future<String> getAppLanguage() async {
    String? language = prefs.getAppLanguage();
    AppLanguage.en.name;
    if (language.isNotEmpty) {
      return language;
    } else {
      return AppLanguage.ar.name;
    }
  }

  Future<void> setAppLanguage(String languageType) async {
    prefs.setAppLanguage(languageType);
  }

  Future<void> setBoolValue(bool value, String key) async {
    prefs.setBoolValue(value, key);
    prefs.getBoolValue(key);
  }

  setAccessToken(
    String value,
  ) {
    token = value;
    prefs.setAccessToken(
      value,
    );
  }

  bool getBoolValue(String key) {
    return prefs.getBoolValue(key);
  }

  removeToken() {
    token = "";
    prefs.removeItem(AppPrefsKeys.TOKEN);
  }

  getGeneral() async {
    GetGeneralUseCase getGeneralUseCase = sl();
    final result = await getGeneralUseCase(());
    result!.fold((l) {}, (r) {
      generalData = r.data;
    });
  }

  Future<void> launchUrlFun(url, {var website = false}) async {
    log(url.toString());

    if (website == false) {
      if (!await launchUrl(Uri.parse(url!))) throw 'Could not launch $url';
    } else {
      if (!await launchUrl(Uri.parse(url!), mode: LaunchMode.inAppWebView)) {
        throw 'Could not launch $url';
      }
    }
  }

  void launchWhatsapp(
    String phone,
  ) async {
    String newPhone = phone
        .trim()
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll(" ", "");
    var url = 'https://api.whatsapp.com/send?phone=$newPhone';
    try {
      if (!await launchUrl(Uri.parse(url),
          mode: LaunchMode.externalApplication)) throw 'Could not launch $url';
    } catch (e) {
      print(e);
    }
  }

  onChangeLanguage(String newValue) {
    if (newValue == AppLanguage.en.name) {
      LocalizationService.changeLocale(AppLanguage.en.name);
      setAppLanguage(AppLanguage.en.name);
    } else {
      LocalizationService.changeLocale(AppLanguage.ar.name);
      setAppLanguage(AppLanguage.ar.name);
    }
  }

  onChangeThemeMode(bool newValue) {
    // Get.changeTheme(newValue ? ThemeData.dark() : ThemeData.light());
    // Get.changeThemeMode(newValue ? ThemeMode.dark : ThemeMode.light);
    // Get.reloadAll();
    darkMode = newValue;
    _darkMode.refresh();
    if (newValue == true) {
      //dark
      setBoolValue(newValue, AppPrefsKeys.DARK);
    } else {
      //light
      setBoolValue(newValue, AppPrefsKeys.DARK);
    }
    _darkMode.refresh();
    update();
  }
}

import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/storage/app_prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  String getAppLanguage() {
    String? language =
        _sharedPreferences.getString(AppPrefsKeys.APP_LANGUAGE) ??
            AppLanguage.en.name;
    if (language.isNotEmpty) {
      return language;
    } else {
      // return default lang
      return AppLanguage.en.name;
    }
  }

  Future<void> setBoolValue(bool value, String key) async {
    await _sharedPreferences.setBool(key, value);
  }

  Future<bool> setString({
    required String key,
    required String value,
  }) async =>
      // await _sharedPreferences.setString(key, json.encode(value));
      await _sharedPreferences.setString(key, value);

  String? getString({
    required String key,
  }) =>
      //_sharedPreferences.getString(json.decode(key));
      _sharedPreferences.getString(key);

  Future<bool> setInt({
    required String key,
    required int value,
  }) async =>
      // await _sharedPreferences.setString(key, json.encode(value));
      await _sharedPreferences.setInt(key, value);

  int? getInt({
    required String key,
  }) =>
      //_sharedPreferences.getString(json.decode(key));
      _sharedPreferences.getInt(key);

  bool getBoolValue(String key) {
    return _sharedPreferences.getBool(key) ?? false;
  }

  bool getThemeValue(String key) {
    return _sharedPreferences.getBool(key) ?? true;
  }

  Future<void> setAppLanguage(String languageType) async {
    _sharedPreferences.setString(AppPrefsKeys.APP_LANGUAGE, languageType);
  }

  //access token
  Future<void> setAccessToken(String accessToken, int userId) async {
    _sharedPreferences.setInt(AppPrefsKeys.USER_ID, userId);
    _sharedPreferences.setString(AppPrefsKeys.TOKEN, accessToken);
  }

  String getAccessToken() {
    return _sharedPreferences.getString(AppPrefsKeys.TOKEN) ?? '';
  }

  Future<void> removeAccessToken() async {
    _sharedPreferences.remove(AppPrefsKeys.USER_ID);
    _sharedPreferences.remove(AppPrefsKeys.TOKEN);
  }

  Future<void> removeItem(String key) async {
    _sharedPreferences.remove(key);
  }

  // //userEntity
  // Future<void> setUserEntity(List<String> user) async {
  //   _sharedPreferences.setStringList(AppPrefsKeys.USER_ENTITY, user);
  // }

  List<String> getUserEntity() {
    return _sharedPreferences.getStringList(AppPrefsKeys.USER_ENTITY) ?? [];
  }

  Future<void> removeUserEntity() async {
    _sharedPreferences.remove(AppPrefsKeys.USER_ENTITY);
  }

  bool getFirstTimeLanguageDialog() {
    return _sharedPreferences.getBool(AppPrefsKeys.LANGUAGE_DIALOG) ?? false;
  }
}

import 'dart:io';

import '../../app/global_imports.dart';

class LoginParams {
  final String? prefix;
  final String? phone;
  final String? password;

  LoginParams({
    this.prefix,
    this.phone,
    this.password,
  });

  LoginParams copyWith({
    String? prefix,
    String? phone,
    String? password,
  }) =>
      LoginParams(
        prefix: prefix ?? this.prefix,
        phone: phone ?? this.phone,
        password: password ?? this.password,
      );

  factory LoginParams.fromJson(Map<String, dynamic> json) => LoginParams(
        prefix: json["prefix"],
        phone: json["phone"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() {
    AppPreferences prefs = sl();
    return {
      "prefix": prefix,
      "phone": phone,
      "password": password,
      "platform": Platform.isIOS ? 'ios' : 'android',
      "player_id": prefs.getString(key: AppPrefsKeys.NOTIFICATION_KEY),
    };
  }
}

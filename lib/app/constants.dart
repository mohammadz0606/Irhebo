// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';

class AppConstants {
  static String platform = Platform.isIOS ? "IOS" : "Android";
  static String versionAPP = Platform.isIOS ? "11" : "10";

  static const englishLocale = Locale('en', 'US');
  static const arabicLocale = Locale('ar', 'KW');
  static const PAGE_LENGTH = 5;
  static const APP_KEY = '123';
  static const APP_SECRET = '123';
  static const String empty = "";
  static const int zero = 0;
  static const int apiTimeOut = 60000;

  static const List<String> passwordConditions = [
    "password first cond",
    "password second cond",
    "password third cond",
    "password fourth cond",
  ];

  static bool isLarge(w) {
    if ((1 * (w / 100)) > 500) {
      return true;
    } else {
      return false;
    }
  }
}

// bool isIpad = AppConstants.isLarge();

///
/// [GetOptions] class is for gathering all the options for the [Dio] package in one class
///

// String getPlatForm() {
//   if (Platform.isWindows) {
//     return "Windows";
//   } else if (Platform.isMacOS) {
//     return "Mac";
//   } else if (Platform.isAndroid) {
//     // if (isIpad) {
//     //   return "Android-Tablet";
//     // } else {
//     //   return "Android-Phone";
//     // }
//   } else if (Platform.isIOS) {
//     // if (isIpad) {
//     //   return " IOS-Tablet";
//     // } else {
//     //   return "IOS-Phone";
//     // }
//   } else {
//     return "";
//   }
// }

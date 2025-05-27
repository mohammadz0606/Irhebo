// ignore_for_file: ant_identifier_names, unused_field

// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  // static final double size8 = (1.99 * (w / 100)); // 8.0;
  // static final double size10 = (2.48 * (w / 100)); // 10.0;
  // static final double size11 = (2.73 * (w / 100)); //11
  // static final double size12 = (2.9 * (w / 100)); //12
  // static final double size13 = (3.23 * (w / 100)); //13
  // static final double size14 = (3.48 * (w / 100)); //14
  // static final double size15 = (3.73 * (w / 100)); //15
  // static final double size16 = (3.98 * (w / 100)); //16
  // static final double size17 = (4.22 * (w / 100)); //17
  // static final double size18 = (4.47 * (w / 100)); //18
  // static final double size20 = (4.97 * (w / 100)); //20
  // static final double size22 = (5.47 * (w / 100)); //22
  // static final double size25 = (6.2 * (w / 100)); //25
  // static final double size26 = (6.46 * (w / 100)); //26
  // static final double size27 = (6.71 * (w / 100)); //27
  // static final double size28 = (6.96 * (w / 100)); //28
  // static final double size30 = (7.46 * (w / 100)); //30
  // static final double size34 = (8.45 * (w / 100)); //34

  static final double size8 = 8.sp; // 8.0;
  static final double size10 = 10.sp; // 10.0;
  static final double size11 = 11.sp; //11
  static final double size12 = 12.sp; //12
  static final double size13 = 13.sp; //13
  static final double size14 = 14.sp; //14
  static final double size15 = 15.sp; //15
  static final double size16 = 16.sp; //16
  static final double size17 = 17.sp; //17
  static final double size18 = 18.sp; //18
  static final double size20 = 20.sp; //20
  static final double size22 = 22.sp; //22
  static final double size25 = 25.sp; //25
  static final double size26 = 26.sp; //26
  static final double size27 = 27.sp; //27
  static final double size28 = 28.sp; //28
  static final double size30 = 30.sp; //30
  static final double size34 = 34.sp; //34

//   static double size8({
//     double? w,
//   }) =>
//       (1.99 * (w! / 100));

//   static double size10({
//     double? w,
//   }) =>
//       (2.48 * (w! / 100));

//   static double size11({
//     double? w,
//   }) =>
//       (2.73 * (w! / 100));

//   static double size12({
//     double? w,
//   }) =>
//       (2.9 * (w! / 100));

//   static double size13({
//     double? w,
//   }) =>
//       (3.23 * (w! / 100));

//   static double size14({
//     double? w,
//   }) =>
//       (3.48 * (w! / 100));

//   static double size15({
//     double? w,
//   }) =>
//       (3.73 * (w! / 100));

//   static double size16({
//     double? w,
//   }) =>
//       (3.98 * (w! / 100));

//   static double size17({
//     double? w,
//   }) =>
//       (4.22 * (w! / 100));

//   static double size18({
//     double? w,
//   }) =>
//       (4.47 * (w! / 100));

//   static double size20({
//     double? w,
//   }) =>
//       (4.97 * (w! / 100));

//   static double size22({
//     double? w,
//   }) =>
//       (5.47 * (w! / 100));

//   static double size25({
//     double? w,
//   }) =>
//       (6.2 * (w! / 100));

//   static double size26({
//     double? w,
//   }) =>
//       (6.46 * (w! / 100));

//   static double size27({
//     double? w,
//   }) =>
//       (6.71 * (w! / 100));

//   static double size28({
//     double? w,
//   }) =>
//       (6.96 * (w! / 100));

//   static double size30({
//     double? w,
//   }) =>
//       (7.46 * (w! / 100));

//   static double size34({
//     double? w,
//   }) =>
//       (8.45 * (w! / 100));
}

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color,
    {TextDecoration? textDecoration}) {
  return TextStyle(
      decoration: textDecoration,
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight);
}
// regular style

TextStyle? getRegularStyle({required Color color, double? fontSize}) {
  return _getTextStyle(fontSize ?? AppTextStyle.size12,
      FontConstants.fontFamilyUnison, FontWeight.w400, color);
}

// medium text style

TextStyle? getMediumStyle({double? fontSize, required Color color}) {
  return _getTextStyle(fontSize ?? AppTextStyle.size12,
      FontConstants.fontFamilyUnison, FontWeight.w500, color);
}
// medium text style

TextStyle? getBoldStyle({double? fontSize, required Color color}) {
  return _getTextStyle(fontSize ?? AppTextStyle.size14,
      FontConstants.fontFamilyUnison, FontWeight.bold, color);
}

TextStyle? getSemiBoldStyle({double? fontSize, required Color color}) {
  return _getTextStyle(fontSize ?? AppTextStyle.size14,
      FontConstants.fontFamilyUnison, FontWeight.w600, color);
}

TextStyle? getSemiBoldUnderLineStyle({double? fontSize, required Color color}) {
  return _getTextStyle(fontSize ?? AppTextStyle.size14,
      FontConstants.fontFamilyUnison, FontWeight.w600, color,
      textDecoration: TextDecoration.underline);
}

class FontConstants {
  static const String fontFamilyUnison = "Mukta";
  // static const String fontFamilyCookie = "cookie";
}

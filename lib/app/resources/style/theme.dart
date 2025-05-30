import 'package:flutter/material.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/text_style.dart';

final darkTheme = ThemeData(
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: Colors.transparent),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      },
    ),
    colorScheme: ColorScheme(
      primary: AppDarkColors.primaryColor,
      onPrimary: AppDarkColors.pureWhite,
      secondary: AppDarkColors.greenContainer,
      onSecondary: AppDarkColors.pureWhite,
      surface: AppDarkColors.darkScaffoldColor,
      onSurface: AppDarkColors.pureWhite.withOpacity(0.5),
      error: Colors.red,
      onError: AppDarkColors.pureWhite,
      brightness: Brightness.light,
      // shadow: Colors.transparent,
    ),
    // useMaterial3: true,
    brightness: Brightness.light,
    // shadowColor: Colors.transparent,
    // hoverColor: AppLightColors.primaryColor.withOpacity(0.4),
    // highlightColor: AppDarkColors.primaryColor.withOpacity(0.4),
    primaryColor: AppLightColors.primaryColor,
    primaryColorLight: AppLightColors.primaryColor.withOpacity(0.4),
    scaffoldBackgroundColor: AppDarkColors.darkScaffoldColor,
    iconTheme: const IconThemeData(color: AppDarkColors.pureWhite),
    textTheme: TextTheme(
      displayLarge: getBoldStyle(
          color: AppDarkColors.primaryColor, fontSize: AppTextStyle.size34),
      displayMedium: getBoldStyle(
          color: AppDarkColors.primaryColor, fontSize: AppTextStyle.size30),
      displaySmall: getBoldStyle(
          color: AppDarkColors.primaryColor, fontSize: AppTextStyle.size28),
      headlineLarge: getBoldStyle(
          color: AppDarkColors.pureWhite, fontSize: AppTextStyle.size30),
      headlineMedium: getBoldStyle(
          color: AppDarkColors.pureWhite, fontSize: AppTextStyle.size26),
      headlineSmall: getBoldStyle(
          color: AppDarkColors.pureWhite, fontSize: AppTextStyle.size20),
      titleLarge: getMediumStyle(
          color: AppDarkColors.pureWhite.withOpacity(0.5),
          fontSize: AppTextStyle.size18),
      titleMedium: getMediumStyle(
          color: AppDarkColors.pureWhite.withOpacity(0.5),
          fontSize: AppTextStyle.size16),
      titleSmall: getMediumStyle(
          color: AppDarkColors.pureWhite.withOpacity(0.5),
          fontSize: AppTextStyle.size14),
      bodyLarge: getRegularStyle(
          color: AppDarkColors.pureWhite.withOpacity(0.5),
          fontSize: AppTextStyle.size18),
      bodyMedium: getRegularStyle(
          color: AppDarkColors.pureWhite.withOpacity(0.5),
          fontSize: AppTextStyle.size16),
      bodySmall: getRegularStyle(
          color: AppDarkColors.pureWhite.withOpacity(0.5),
          fontSize: AppTextStyle.size14),
      labelLarge: getMediumStyle(
          color: AppDarkColors.pureWhite, fontSize: AppTextStyle.size16),
      labelMedium: getMediumStyle(
          color: AppDarkColors.pureWhite, fontSize: AppTextStyle.size14),
      labelSmall: getMediumStyle(
          color: AppDarkColors.pureWhite, fontSize: AppTextStyle.size12),
    ),
    //
    popupMenuTheme: PopupMenuThemeData(
        color: AppDarkColors.darkContainer,
        labelTextStyle: WidgetStateProperty.all(TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: AppTextStyle.size14)),
        textStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: AppTextStyle.size14),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none)),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: AppDarkColors.darkScaffoldColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: AppDarkColors.darkContainer,
      foregroundColor: AppDarkColors.pureWhite.withOpacity(0.5),
      // shadowColor: Colors.transparent,
      titleTextStyle: TextStyle(
          fontFamily: FontConstants.fontFamilyUnison,
          fontSize: AppTextStyle.size18,
          fontWeight: FontWeight.w700,
          height: null,
          color: Colors.white),
      iconTheme: const IconThemeData(
        color: AppDarkColors.pureWhite,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppDarkColors.primaryColor,
        foregroundColor: AppDarkColors.primaryColor),
    switchTheme: SwitchThemeData(
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
        trackColor: WidgetStateProperty.all(AppDarkColors.switcher),
        thumbColor: WidgetStateProperty.all(AppDarkColors.pureWhite)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppDarkColors.primaryColor,
        foregroundColor: AppDarkColors.pureWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
        elevation: 0,
        textStyle: TextStyle(
          fontSize: AppTextStyle.size14,
          fontWeight: FontWeight.w700,
          fontFamily: FontConstants.fontFamilyUnison,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppDarkColors.pureWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
        elevation: 0,
        textStyle: TextStyle(
          fontSize: AppTextStyle.size14,
          fontWeight: FontWeight.w700,
          fontFamily: FontConstants.fontFamilyUnison,
        ),
      ),
    ),
    dividerTheme: DividerThemeData(
        color: AppDarkColors.pureWhite.withOpacity(0.2),
        thickness: 1,
        space: 1),
    listTileTheme: const ListTileThemeData(),
    fontFamily: FontConstants.fontFamilyUnison,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppDarkColors.darkScaffoldColor,
      unselectedIconTheme: const IconThemeData(color: Colors.grey, size: 20),
      unselectedItemColor: AppDarkColors.darkContainer,
      unselectedLabelStyle: TextStyle(
          fontSize: AppTextStyle.size14,
          fontWeight: FontWeight.w700,
          color: AppDarkColors.darkContainer),
      selectedIconTheme: IconThemeData(
          color: AppDarkColors.pureWhite.withOpacity(0.5), size: 25),
      selectedItemColor: AppDarkColors.pureWhite.withOpacity(0.5),
      selectedLabelStyle: TextStyle(
          fontSize: AppTextStyle.size14,
          fontWeight: FontWeight.w700,
          color: AppDarkColors.pureWhite.withOpacity(0.5)),
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),
    checkboxTheme: CheckboxThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: BorderSide(
        color: AppDarkColors.pureWhite.withOpacity(0.5),
        width: 1,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
          side: BorderSide(
              color: AppDarkColors.pureWhite.withOpacity(0.5), width: 1)),
      checkColor: WidgetStateProperty.all<Color>(AppDarkColors.pureWhite),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppDarkColors.darkScaffoldColor,
      barrierColor: AppDarkColors.darkContainer.withOpacity(0.3),
    ),
    cardTheme: CardThemeData(
      elevation: 15,
      color: AppDarkColors.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        border: kOutlinedBorderWhite,
        focusedBorder: kOutlinedBorderWhite,
        enabledBorder: kOutlinedBorderWhite,
        errorBorder: kOutlinedBorderRed,
        focusedErrorBorder: kOutlinedBorderRed,
        fillColor: AppDarkColors.darkContainer.withOpacity(0.5),
        hintStyle: getRegularStyle(
            color: AppDarkColors.pureWhite.withOpacity(0.5),
            fontSize: AppTextStyle.size14)));

/////
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///\
///
///
///
///
///
///
///
///////

final lightTheme = ThemeData(
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: Colors.transparent),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      },
    ),
    colorScheme: const ColorScheme(
      primary: AppLightColors.primaryColor,
      onPrimary: AppLightColors.pureWhite,
      secondary: AppLightColors.secondary,
      onSecondary: AppLightColors.primaryColor,
      surface: AppLightColors.secondary,
      onSurface: AppLightColors.primaryColor,
      error: Colors.red,
      onError: AppLightColors.pureWhite,
      brightness: Brightness.dark,
      // shadow: AppLightColors.shadow.withOpacity(0.3),
    ),
    brightness: Brightness.dark,
    // shadowColor: AppLightColors.primaryColor.withOpacity(0.3),
    // hoverColor: AppLightColors.primaryColor.withOpacity(0.3),
    // splashColor: AppLightColors.primaryColor.withOpacity(0.5),
    // highlightColor: AppLightColors.secondary,
    primaryColor: AppLightColors.primaryColor,
    primaryColorLight: AppLightColors.primaryColor.withOpacity(0.3),
    scaffoldBackgroundColor: AppLightColors.scaffoldColor2,
    ////
    iconTheme: const IconThemeData(color: AppLightColors.primaryColor),
    textTheme: TextTheme(
      displayLarge: getBoldStyle(
          color: AppLightColors.primaryColor, fontSize: AppTextStyle.size34),
      displayMedium: getBoldStyle(
          color: AppLightColors.primaryColor, fontSize: AppTextStyle.size30),
      displaySmall: getBoldStyle(
          color: AppLightColors.primaryColor, fontSize: AppTextStyle.size28),
      headlineLarge:
          getBoldStyle(color: Colors.black, fontSize: AppTextStyle.size30),
      headlineMedium:
          getBoldStyle(color: Colors.black, fontSize: AppTextStyle.size26),
      headlineSmall:
          getBoldStyle(color: Colors.black, fontSize: AppTextStyle.size20),
      titleLarge: getMediumStyle(
          color: Colors.black.withOpacity(0.5), fontSize: AppTextStyle.size18),
      titleMedium: getMediumStyle(
          color: Colors.black.withOpacity(0.5), fontSize: AppTextStyle.size16),
      titleSmall: getMediumStyle(
          color: Colors.black.withOpacity(0.5), fontSize: AppTextStyle.size14),
      bodyLarge: getRegularStyle(
          color: Colors.black.withOpacity(0.5), fontSize: AppTextStyle.size18),
      bodyMedium: getRegularStyle(
          color: Colors.black.withOpacity(0.5), fontSize: AppTextStyle.size16),
      bodySmall: getRegularStyle(
          color: Colors.black.withOpacity(0.5), fontSize: AppTextStyle.size14),
      labelLarge:
          getMediumStyle(color: Colors.black, fontSize: AppTextStyle.size16),
      labelMedium:
          getMediumStyle(color: Colors.black, fontSize: AppTextStyle.size14),
      labelSmall:
          getMediumStyle(color: Colors.black, fontSize: AppTextStyle.size12),
    ),
    //
    popupMenuTheme: PopupMenuThemeData(
        color: AppLightColors.scaffoldColor,
        labelTextStyle: WidgetStateProperty.all(TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: AppTextStyle.size14)),
        textStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: AppTextStyle.size14),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none)),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: AppLightColors.scaffoldColor2,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: AppLightColors.secondary,
      foregroundColor: AppLightColors.primaryColor,
      // shadowColor: AppLightColors.greyBody,
      titleTextStyle: TextStyle(
          fontFamily: FontConstants.fontFamilyUnison,
          fontSize: AppTextStyle.size18,
          fontWeight: FontWeight.w700,
          height: null,
          color: Colors.black),
      iconTheme: const IconThemeData(
        color: AppLightColors.secondary,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppLightColors.primaryColor,
        foregroundColor: AppLightColors.primaryColor),
    switchTheme: SwitchThemeData(
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
        trackColor: WidgetStateProperty.all(AppLightColors.primaryColor),
        thumbColor: WidgetStateProperty.all(AppLightColors.pureWhite)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppLightColors.primaryColor,
        foregroundColor: AppLightColors.pureWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
        elevation: 6,
        textStyle: TextStyle(
          fontSize: AppTextStyle.size14,
          fontWeight: FontWeight.w700,
          fontFamily: FontConstants.fontFamilyUnison,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppDarkColors.darkScaffoldColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
        elevation: 0,
        textStyle: TextStyle(
          fontSize: AppTextStyle.size14,
          fontWeight: FontWeight.w700,
          fontFamily: FontConstants.fontFamilyUnison,
        ),
      ),
    ),

    dividerTheme: const DividerThemeData(
        color: AppLightColors.dividerColor, thickness: 1, space: 1),
    dividerColor: AppLightColors.dividerColor,
    listTileTheme: const ListTileThemeData(),
    fontFamily: FontConstants.fontFamilyUnison,
    checkboxTheme: CheckboxThemeData(
      side: const BorderSide(
        color: AppLightColors.primaryColor,
        width: 1,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
          side: const BorderSide(color: AppLightColors.primaryColor, width: 1)),
      checkColor: WidgetStateProperty.all<Color>(AppLightColors.primaryColor),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppLightColors.pureWhite,
      barrierColor: AppLightColors.shadow.withOpacity(0.3),
    ),
    cardTheme: CardThemeData(
      elevation: 15,
      color: AppLightColors.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        border: kOutlinedBorderWhite,
        focusedBorder: kOutlinedBorderWhite,
        enabledBorder: kOutlinedBorderWhite,
        errorBorder: kOutlinedBorderRed,
        focusedErrorBorder: kOutlinedBorderRed,
        fillColor: AppLightColors.fillTextField,
        hintStyle: getRegularStyle(
            color: Colors.black.withOpacity(0.5),
            fontSize: AppTextStyle.size14)));

import 'dart:developer';

import 'package:irhebo/app/error/exceptions.dart';
import 'package:irhebo/app/resources/logger_colors.dart';

import '../enums.dart';

///
///
/// [ErrorHandler] class is responsible of handling all the remote, local and user's input error
///
class ErrorHandler {
  /// [handleRemoteError] decides if the remote request has succeeded or not
  ///
  /// Returns:
  ///   true if there were no errors
  ///
  /// Throws:
  ///  [ServerException] in the following cases
  ///   a- With [ErrorCode.UNAUTHENTICATED]
  ///   b- With [ErrorCode.WRONG_INPUT]
  ///   c- With [ErrorCode.FORBIDDEN]
  ///   d- With [ErrorCode.SERVER_ERROR]
  ///
  static Future<bool> handleRemoteError(int statusCode, String? message) async {
    // final sharedPreferences =  SharedPreferences.getInstance();
    log("${AppLoggerColors.green}${statusCode}STATUS CODE");
    log("${AppLoggerColors.green} $message");
    if (statusCode >= 200 && statusCode < 300) {
      return true;
    } else if (statusCode == 401) {
      // SharedPreferences prefrences = await SharedPreferences.getInstance();
      // prefrences.remove(AppPrefsKeys.TOKEN);
      // AppSnackBar.createError(
      //     context: GlobalVariable.navState.currentState!.context,
      //     message: getErrorMessage(ErrorCode.UNAUTHENTICATED));

      // Get.offAllNamed(AppRoutes.login);
      //  GlobalVariable.navState.currentState!.context,
    } else if (statusCode == 403) {
      // CustomFlushBarHelper.createError(
      //     context: GlobalVariable.navState.currentState!.context,
      //     message: getErrorMessage(ErrorCode.FORBIDDEN));
    } else if (statusCode == 500) {
      // CustomFlushBarHelper.createError(
      //     context: GlobalVariable.navState.currentState!.context,
      //     message: getErrorMessage(ErrorCode.SERVER_ERROR));
      // throw ServerException(ErrorCode.SERVER_ERROR, message ?? "");
    }
    return false;
  }

  static String getErrorMessage(ErrorCode error) {
    switch (error) {
      case ErrorCode.BAD_REQUEST:
        return "BAD REQUEST";
      case ErrorCode.CACH_ERROR:
        return "CACH ERROR";
      case ErrorCode.FORBIDDEN:
        return "FORBIDDEN";
      case ErrorCode.NOT_VERIFIED:
        return "NOT VERIFIED";
      case ErrorCode.NO_INTERNET_CONNECTION:
        return "NO INTERNET CONNECTION";
      case ErrorCode.PARSE_ERROR:
        return "PARSE ERROR";
      case ErrorCode.REGISTERED_EMAIL:
        return "REGISTERED EMAIL";
      case ErrorCode.SERVER_ERROR:
        return "SERVER ERROR";
      case ErrorCode.TIMEOUT:
        return "Connection Timeout";
      case ErrorCode.UNAUTHENTICATED:
        return "UNAUTHENTICATED";
      case ErrorCode.WRONG_INPUT:
        return "WRONG INPUT";
      case ErrorCode.IDENTIFIER_TAKEN:
        return "IDENTIFIER TAKEN";
    }
  }
}

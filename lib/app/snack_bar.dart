import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';

class AppSnackBar {
  static void openErrorSnackBar({String? title, String message = ''}) {
    // if (Get.isSnackbarOpen) Get.back();

    Get.snackbar(
      backgroundColor: Get.find<AppController>().darkMode
          ? AppDarkColors.redBadge
          : AppDarkColors.red.withOpacity(0.9),
      colorText: Get.find<AppController>().darkMode
          ? Get.theme.secondaryHeaderColor
          : Colors.white,
      title ?? 'Sorry'.tr,
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static void openSuccessSnackBar({String? title, String message = ''}) {
    Get.snackbar(
      backgroundColor: Get.find<AppController>().darkMode
          ? AppDarkColors.greenContainer
          : AppLightColors.primaryColor.withOpacity(0.9),
      colorText: Get.find<AppController>().darkMode
          ? Get.theme.secondaryHeaderColor
          : Colors.white,
      title ?? "Success".tr,
      message,
      snackPosition: SnackPosition.TOP,
    );
  }

  static void openSnackBar({String title = '', String message = ''}) {
    Get.snackbar(
      // backgroundColor: const Color(0xFFB4EDC3).withOpacity(0.4),
      colorText: Colors.white,
      title,
      message,
      snackPosition: SnackPosition.TOP,
    );
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Get.theme.primaryColor.withOpacity(0.8)
        // duration
        );
  }

  static void openLoadingDialog({Color? color}) {
    if (Get.isDialogOpen!) return;
    Get.dialog(
        barrierDismissible: false,
        Container(
            alignment: Alignment.center,
            height: 100,
            width: 100,
            child: CircularProgressIndicator(
              color: color ?? Get.theme.primaryColor,
            )));
  }

  static void openMessageDialog({required String message}) {
    if (Get.isDialogOpen!) Get.back();

    AlertDialog alertDialog = AlertDialog(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        content: Text(message));
    Get.dialog(alertDialog);
  }

  static void showCustomSnackBar(String message, {bool isError = true}) {
    if (message.isNotEmpty) {
      Get.showSnackbar(GetSnackBar(
        snackPosition: SnackPosition.TOP,
        backgroundColor: isError ? Colors.red : const Color(0xff3BE038),
        message: message,

        // maxWidth: MediaQuery.of(context).size.WEB_MAX_WIDTH,
        duration: const Duration(seconds: 6),
        snackStyle: SnackStyle.FLOATING,
        margin: const EdgeInsets.all(15),

        borderRadius: 10,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
      ));
    }
  }

  static createSuccess(
      {String? title,
      required String message,
      required BuildContext context,
      int timeout = 4,
      Color? background,
      bool top = false,
      EdgeInsets? padding,
      EdgeInsets? margin}) {
    var w = MediaQuery.of(context).size.width;

    return Flushbar(
      title: (title ?? "Success!").tr,
      message: message,
      barBlur: 5.0,
      flushbarStyle: FlushbarStyle.FLOATING,
      icon: Icon(
        Icons.info,
        color: Colors.white,
      ),
      maxWidth: (1 * w) / 1.08,
      leftBarIndicatorColor: Color(0xFF0E9E22),
      backgroundColor: Color(0xFF0E9E22).withOpacity(0.7),
      duration: Duration(seconds: timeout),
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(12),
      messageText: Text(
        message,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
      ),
    ).show(context);
  }

  static createError(
      {String? title,
      required String message,
      required BuildContext context,
      int timeout = 4}) {
    var w = MediaQuery.of(context).size.width;

    return Flushbar(
      title: (title ?? "Sorry!").tr,
      message: message,
      barBlur: 5.0,
      flushbarStyle: FlushbarStyle.FLOATING,
      icon: Icon(
        Icons.info,
        color: Colors.white,
      ),
      maxWidth: (1 * w) / 1.08,
      leftBarIndicatorColor: AppDarkColors.redBadge,
      backgroundColor: AppDarkColors.redBadge.withOpacity(0.7),
      duration: Duration(seconds: timeout),
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(12),
      messageText: Text(
        message,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
      ),
    ).show(context);
  }
}

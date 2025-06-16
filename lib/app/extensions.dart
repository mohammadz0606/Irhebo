import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

final MediaQueryData media =
    MediaQueryData.fromView(WidgetsBinding.instance.window);
// final appSize = Get.size;

extension FormatMonthTitle on DateTime {
  String formatMonth() {
    return DateFormat('MMMM', 'en').format(this);
  }
}

extension FormatYearTitle on DateTime {
  String formatYear() {
    return DateFormat('yyyy', 'en').format(this);
  }

  String get formatDateWithMonthName {
    return DateFormat('MMM dd,yyyy').format(this);
  }
}

extension Target on Object {
  String platform() {
    if (Platform.isAndroid) {
      return "android";
    } else if (Platform.isIOS) {
      return "ios";
    } else if (Platform.isLinux) {
      return "linux";
    } else if (Platform.isWindows) {
      return "windows";
    } else if (Platform.isMacOS) {
      return "macOS";
    } else {
      return "web";
    }
  }
}

extension TimeOfDayExtension on TimeOfDay {
  // Ported from org.threeten.bp;
  TimeOfDay plusMinutes(int minutes) {
    if (minutes == 0) {
      return this;
    } else {
      int mofd = hour * 60 + minute;
      int newMofd = ((minutes % 1440) + mofd + 1440) % 1440;
      if (mofd == newMofd) {
        return this;
      } else {
        int newHour = newMofd ~/ 60;
        int newMinute = newMofd % 60;
        return TimeOfDay(hour: newHour, minute: newMinute);
      }
    }
  }
}

/// This extention help us to make widget responsive.
extension NumberParsing on num {
  double w() => this / 100 * (media.size.width);

  double h() => this / 100 * (media.size.height);

  double hWithAppBar() =>
      this * (media.size.height - AppBar().preferredSize.height);
}

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }

  String get requestFilterTitle {
    switch(this) {
      case "all":
        return 'all new'.tr;
      case "pending":
        return "pending new".tr;
      case "in_progress":
        return "in_progress new".tr;
      case "completed":
        return "completed new".tr;
      case "cancelled":
        return "cancelled new".tr;
      case "confirmed" :
        return "confirmed new".tr;
      default:
        return "";
    }
  }
}

extension OnString on String? {
  DateTime get toDateTime {
    try {
      return DateFormat("EEE, MMM d, yyyy h:mm a").parse(this!);
    } catch (e) {
      return DateTime.now();
    }
  }

  String get formatDateWithMonthName {
    try {
      final parsedDate = this?.toDateTime;
      return DateFormat('MMM dd, yyyy').format(parsedDate!);
    } catch (e) {
      return "";
    }
  }

  String get formatTimeAgo {
    final dateTime = DateTime.parse(this ?? DateTime.now().toString());
    return timeago.format(dateTime);
  }
}

// extension NonNullString on String? {
//   String orEmpty() {
//     if (this == null) {
//       return Constants.empty;
//     } else {
//       return this!;
//     }
//   }
// }

// extension NonNullInteger on int? {
//   int orZero() {
//     if (this == null) {
//       return Constants.zero;
//     } else {
//       return this!;
//     }
//   }
// }

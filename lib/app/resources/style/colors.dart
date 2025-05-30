import 'package:flutter/material.dart';
import 'package:irhebo/app/enums.dart';

class AppDarkColors {
  //dark
  static const Color primaryColor = Color(0xff49356E);
  static const Color primaryColor2 = Color(0xff9932cc);
  static const Color darkPrimary = Color(0xff3e2f5b);
  static const Color darkPrimary3 = Color(0xff49037C);
  static const Color darkCover = Color(0xff372b4e);
  static const Color darkPrimary2 = Color(0xff26222d);
  static const Color logout = Color(0xffDC2626);
  // static const Color lightPrimary = Color(0xffddd5e4);
  // static const Color lightPrimary2 = Color(0xffddd5e4);
  // static const Color scaffoldColor = Color(0xFFfbfbfb);
  // static const Color fillTextField = Color(0xFFf8f8fa);
  static const Color whatsappColor = Color(0xff2ab319);
  static const Color dark3 = Color(0xff1e1e1e);
  static const Color caption = Color(0xFF808080);
  static const Color darkContainer2 = Color(0xFF2c2c2c);
  static const Color redBadge = Color(0xFFE94242);
  static const Color inProgressIssue = Color(0xFF007BFF);
  static const Color deferred = Color(0xFFFD7E14);
  static const Color open = Color(0xFF28A745);
  static const Color solved = Color(0xFF45C49C);

  static const Color darkScaffoldColor = Color(0xFF181818);
  static const Color pureBlack = Color(0x00000000);
  static const Color darkContainer = Color(0xFF333333);
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color greyText = Color(0xFF959595);
  static const Color fillColor = Color(0xFF262626);
  static const Color greyLabel = Color(0xFF5c5c5c);
  static const Color unselected = Color(0xFFD9D9D9);
  static const Color borderColor = Color(0xFF4a4a4a);
  static const Color greyBody = Color(0xFF8e8e8e);
  static const Color green = Color(0xFF099361);
  static const Color greenText = Color(0xFF07935F);
  static const Color greenText2 = Color(0xFF09935e);
  static const Color greenContainer = Color(0xFF089361);
  static const Color darkGreen = Color(0xFF1a6047);
  static const Color greyTitle = Color(0xFF8b8b8b);
  static const Color linkedin = Color(0xFF007ebb);
  static const Color darkGreen2 = Color(0xFF2f4b35);
  static const Color greyCaption = Color(0xFF929292);
  static const Color darkBlue = Color(0xFF4B5563);
  static const Color lightGreen = Color(0xFF34c759);
  static const Color yellow = Color(0xFFffcc01);
  static const Color pending = Color(0xFFFFC107);
  static const Color confirmed = Color(0xFF2196F3);
  static const Color inProgress = Color(0xFFFF9800);
  static const Color completed = Color(0xFF4CAF50);
  static const Color canceled = Color(0xFFF44336);
  static const Color darkYellow = Color(0xFF564c23);
  static const Color orange = Color(0xFFff9502);
  static const Color switcher = Color(0xFF006B40);
  static const Color red = Color(0xFFff3b31);
  static const Color darkrRed = Color(0xFFc20000);
  static const Color darkRed2 = Color(0xFF4a2323);
  static const Color black = Color(0xFF1D1D1D);

  static const List<Color> strengthenColorsList = [
    red,
    orange,
    yellow,
    lightGreen
  ];

  // static const Map<RequestSenderType, Color> senderTypeColor = {
  //   RequestSenderType.Freelancer: AppColors.primaryColor,
  //   RequestSenderType.Client: AppColors.lightGreen,
  //   RequestSenderType.Admin: AppColors.red
  // };

  static const Map<String, Color> statusColor = {
    "inprogress": inProgress,
    "completed": completed,
    "cancelled": canceled,
    "pending": pending,
    "confirmed": confirmed,
    "all": completed,
  };

  static const Map<Enum, Color> ticketStatus = {
    TicketStatus.Pending: inProgressIssue,
    TicketStatus.Open: open,
    TicketStatus.Closed: solved,
    TicketStatus.Resolved: deferred,
  };

  static const List<Color> gradientGreenContainer = [
    Color(0xff006B40),
    Color(0xff2BDA89),
  ];

  static const List<Color> shadowGradient = [
    Color(0xff212121),
    Color(0xff212121),
  ];
}

OutlineInputBorder kOutlinedBorderWhite = const OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(14)),
  borderSide: BorderSide(width: 0, color: Colors.transparent),
);

OutlineInputBorder searchFeild = const OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(500)),
  borderSide: BorderSide(
    width: 0,
    color: Colors.transparent,
  ),
);

OutlineInputBorder kOutlinedBorderBlack = const OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(14)),
  borderSide: BorderSide(color: AppDarkColors.pureBlack),
);
OutlineInputBorder kOutlinedBorderRed = const OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(14)),
  borderSide: BorderSide(color: AppDarkColors.red),
);

OutlineInputBorder dropDownOutlinedBorder = const OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(14)),
  borderSide: BorderSide(color: Colors.transparent, width: 0),
);

BoxDecoration pinputDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(14),
    color: AppDarkColors.darkContainer.withOpacity(0.5)
    // border: Border.all(color: Get.theme.primaryColor),
    );
BoxDecoration pinputLightDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(14),
  color: AppLightColors.pinputColor.withOpacity(0.45),

  // border: Border.all(color: Get.theme.primaryColor),
);
BoxDecoration focusedPinputDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(14),
  color: AppDarkColors.darkContainer.withOpacity(0.5),
  // border: Border.all(
  //   color: Color(0xff006B40),
  // )
);

BoxDecoration focusedPinputLightDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(14),
  color: AppLightColors.pinputColor.withOpacity(0.45),
  // border: Border.all(
  //   color: Color(0xff006B40),
  // )
);

BorderRadiusDirectional senderRadius = const BorderRadiusDirectional.only(
    topEnd: Radius.zero,
    topStart: Radius.circular(27),
    bottomEnd: Radius.circular(27),
    bottomStart: Radius.circular(27));

BorderRadiusDirectional receiverRadius = const BorderRadiusDirectional.only(
    topEnd: Radius.circular(27),
    topStart: Radius.circular(27),
    bottomEnd: Radius.circular(27),
    bottomStart: Radius.zero);

class AppLightColors {
  static const Color secondary = Color(0xffe9e2ee);
  static const Color searchTextField = Color(0xffeeebf1);
  static const Color dividerColor = Color(0xffd2d2d2);
  static const Color unSelected = Color(0xffedebf0);

  //dark
  static const Color primaryColor = Color(0xff49356E);
  static const Color primaryColor2 = Color(0xff9932cc);
  static const Color darkPrimary = Color(0xff3e2f5b);
  static const Color darkPrimary3 = Color(0xff49037C);
  static const Color darkCover = Color(0xff372b4e);
  static const Color darkPrimary2 = Color(0xff26222d);
  static const Color pinputColor = Color(0xffEDE6F2);
  static const Color lightPrimary = Color(0xffddd5e4);
  static const Color lightPrimary2 = Color(0xffddd5e4);
  static const Color scaffoldColor = Color(0xFFFBFBFB);
  static const Color scaffoldColor2 = Color(0xFFF7F7F7);
  static const Color fillTextField = Color(0xFFf8f8fa);
  static const Color whatsappColor = Color(0xff2ab319);
  static const Color dark3 = Color(0xff1e1e1e);
  static const Color caption = Color(0xFF808080);
  static const Color darkContainer2 = Color(0xFF2c2c2c);
  static const Color redBadge = Color(0xFFE94242);
  static const Color inProgressIssue = Color(0xFF007BFF);
  static const Color deferred = Color(0xFFFD7E14);
  static const Color open = Color(0xFF28A745);
  static const Color solved = Color(0xFF45C49C);

  static const Color darkScaffoldColor = Color(0xFF181818);
  static const Color pureBlack = Color(0x00000000);
  static const Color darkContainer = Color(0xFF333333);
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color greyText = Color(0xFF959595);
  static const Color fillColor = Color(0xFF262626);
  static const Color greyLabel = Color(0xFF5c5c5c);
  static const Color unselected = Color(0xFFD9D9D9);
  static const Color borderColor = Color(0xFF4a4a4a);
  static const Color greyBody = Color(0xFF8e8e8e);
  static const Color green = Color(0xFF099361);
  static const Color greenText = Color(0xFF07935F);
  static const Color greenText2 = Color(0xFF09935e);
  static const Color shadow = Color(0xFF212121);
  static const Color greenContainer = Color(0xFF089361);
  static const Color darkGreen = Color(0xFF1a6047);
  static const Color greyTitle = Color(0xFF8b8b8b);
  static const Color linkedin = Color(0xFF007ebb);
  static const Color darkGreen2 = Color(0xFF2f4b35);
  static const Color greyCaption = Color(0xFF929292);
  static const Color darkBlue = Color(0xFF4B5563);
  static const Color lightGreen = Color(0xFF34c759);
  static const Color yellow = Color(0xFFffcc01);
  static const Color pending = Color(0xFFFFC107);
  static const Color confirmed = Color(0xFF2196F3);
  static const Color inProgress = Color(0xFFFF9800);
  static const Color completed = Color(0xFF4CAF50);
  static const Color canceled = Color(0xFFF44336);
  static const Color darkYellow = Color(0xFF564c23);
  static const Color orange = Color(0xFFff9502);
  static const Color switcher = Color(0xFF006B40);
  static const Color red = Color(0xFFff3b31);
  static const Color darkrRed = Color(0xFFc20000);
  static const Color darkRed2 = Color(0xFF4a2323);
  static const Color black = Color(0xFF1D1D1D);

  static const List<Color> strengthenColorsList = [
    red,
    orange,
    yellow,
    lightGreen
  ];

  // static const Map<RequestSenderType, Color> senderTypeColor = {
  //   RequestSenderType.Freelancer: primaryColor,
  //   RequestSenderType.Client: lightGreen,
  //   RequestSenderType.Admin: red
  // };

  static const Map<String, Color> statusColor = {
    "InProgress": inProgress,
    "Completed": completed,
    "Cancelled": canceled,
    "Pending": pending,
    "Confirmed": confirmed,
    "All": completed,
  };

  static const Map<Enum, Color> ticketStatus = {
    TicketStatus.Pending: inProgressIssue,
    TicketStatus.Open: open,
    TicketStatus.Closed: solved,
    TicketStatus.Resolved: deferred,
  };

  static const List<Color> gradientGreenContainer = [
    // Color(0xff006B40),
    // Color(0xff2BDA89),
    Color(0xff49037C),
    Color(0xff49037C),
    // Color.fromARGB(255, 36, 125, 227),
  ];

  static const List<Color> shadowGradient = [
    Color(0xff212121),
    Color(0xff212121),
  ];
}

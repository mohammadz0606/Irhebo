import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';

class TicketStatusWidget extends StatelessWidget {
  final TicketStatus type;

  const TicketStatusWidget({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 0.99 * (w / 100), horizontal: 3.98 * (w / 100)),
      decoration: AppDecoration.getDecorationWithRadius(
          color: AppDarkColors.ticketStatus[type]),
      child: Text(
        type.name.tr,
        style: Get.theme.textTheme.labelSmall!.copyWith(
            fontWeight: FontWeight.w700,
            color: type == TicketStatus.Closed
                ? AppDarkColors.dark3
                : Get.find<AppController>().darkMode
                    ? null
                    : Colors.white),
      ),
    );
  }
}

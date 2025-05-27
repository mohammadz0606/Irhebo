import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/app_functions.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/domain/models/ticket_model.dart';
import 'package:irhebo/presentation/screens/support_tickets/widgets/ticket_status_widget.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';

class TicketWidget extends StatelessWidget {
  final TicketModel ticket;

  const TicketWidget({
    super.key,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      decoration: AppDecoration.getDecorationWithRadius(
          color: Get.find<AppController>().darkMode
              ? AppDarkColors.darkContainer2
              : Colors.white,
          radius: 12),
      // color: Colors.green,
      margin: EdgeInsets.symmetric(vertical: 1.49 * (w / 100)),
      padding: EdgeInsets.all(3.99 * (w / 100)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.99 * (w / 100)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "#${ticket.id} " + "${ticket.subject}",
                        style: Get.theme.textTheme.labelLarge!
                            .copyWith(fontWeight: FontWeight.w700),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        width: 1 * (w / 100),
                      ),
                      // Visibility(
                      //   visible: 6 > 0,
                      //   child: Container(
                      //     height: 3.5 * (w / 100),
                      //     width: 3.5 * (w / 100),
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(30),
                      //         shape: BoxShape.rectangle,
                      //         border: Border.all(
                      //             color: AppColors.pureWhite, width: 1),
                      //         color: Colors.red),
                      //   ),
                      // ),
                    ],
                  ),
                  Text(
                    ticket.createdAt ?? "",
                    style: Get.theme.textTheme.labelSmall!.copyWith(
                        color: Get.find<AppController>().darkMode
                            ? AppDarkColors.pureWhite.withOpacity(0.5)
                            : Colors.black.withOpacity(0.5)),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              TicketStatusWidget(
                type: getTicketStatusByLabel(ticket.status!.toLowerCase()),
              ),
              SizedBox(
                width: 1.99 * (w / 100),
              ),
              AppIcon(
                width: 5.47 * (w / 100),
                height: 5.47 * (w / 100),
                path: AppIcons.next,
                matchTextDirection: true,
                // isSvg: false,
                color: Get.find<AppController>().darkMode
                    ? AppDarkColors.pureWhite
                    : Colors.black,
              )
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/domain/models/ticket_model.dart';
import 'package:irhebo/presentation/screens/ticket_details/widgets/attachment_row.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';

class TicketResponseCard extends StatelessWidget {
  final bool user;
  final TicketModel ticket;
  final Function(int) onTapAttachment;
  const TicketResponseCard({
    super.key,
    this.user = true,
    required this.ticket,
    required this.onTapAttachment,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.99 * (w / 100)),
      padding: EdgeInsets.all(
        3.98 * (w / 100),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: user ? Radius.zero : Radius.circular(12),
            bottomLeft: user ? Radius.circular(12) : Radius.zero,
            bottomRight: Radius.circular(12),
            topLeft: Radius.circular(12)),
        color: user
            ? Get.find<AppController>().darkMode
                ? AppDarkColors.darkContainer
                : Colors.white
            : Get.find<AppController>().darkMode
                ? AppDarkColors.primaryColor
                : AppDarkColors.greenContainer,
      ),
      // decoration: AppDecoration.getDecorationWithRadius(
      //     radius: 12,
      //     color: user ? AppColors.darkContainer : AppColors.primaryColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              user
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: AppImage(
                        imageUrl: ticket.sender?.avatar ?? "",
                        width: 7.9 * (w / 100),
                        height: 7.9 * (w / 100),
                      ),
                    )
                  : AppIcon(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      path: AppIcons.customer,
                      color: Colors.white,
                      width: 7.9 * (w / 100),
                      height: 7.9 * (w / 100),
                    ),
              SizedBox(
                width: 1.99 * (w / 100),
              ),
              Text(
                ticket.sender?.username ?? "",
                style: Get.theme.textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: user
                        ? null
                        : Get.find<AppController>().darkMode
                            ? null
                            : Colors.white),
              ),
            ],
          ),
          SizedBox(
            height: 3.89 * (w / 100),
          ),
          Text(
            ticket.message ?? "",
            style: Get.theme.textTheme.labelSmall!.copyWith(
                color: user
                    ? null
                    : Get.find<AppController>().darkMode
                        ? null
                        : Colors.white),
          ),
          if (ticket.attachments!.isNotEmpty)
            Padding(
                padding: EdgeInsets.only(top: 3.89 * (w / 100)),
                child: AttachmentRow(
                  attachments: ticket.attachments!,
                  onTapAttachment: (i) => onTapAttachment(i),
                )),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              ticket.createdAt ?? "",
              style: Get.theme.textTheme.labelSmall!.copyWith(
                  color: user
                      ? null
                      : Get.find<AppController>().darkMode
                          ? null
                          : Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

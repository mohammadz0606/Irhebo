import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_functions.dart';
import 'package:irhebo/app/enums.dart';

import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/presentation/screens/chat/widgets/pick_item_widget.dart';
import 'package:irhebo/presentation/screens/ticket_details/widgets/support_text_field.dart';
import 'package:irhebo/presentation/screens/ticket_details/ticket_details_controller.dart';

class TicketDetailsBottomBar extends GetWidget<TicketDetailsController> {
  const TicketDetailsBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return Obx(
      () => controller.isLoading ||
              getTicketStatusByLabel(
                      controller.mainTicket.status!.toLowerCase()) ==
                  TicketStatus.Closed
          ? SizedBox.shrink()
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Animate(
                  autoPlay: false,
                  onInit: (controller2) {
                    controller.galleryAnimationController = controller2;
                  },
                  effects: [
                    FadeEffect(
                        begin: 0,
                        end: 1,
                        duration: 200.ms,
                        curve: Curves.fastLinearToSlowEaseIn),
                    SlideEffect(
                        begin: Offset(0, 3),
                        end: Offset(0, 0),
                        duration: 200.ms,
                        curve: Curves.fastLinearToSlowEaseIn),
                  ],
                  child: PickItemWidget(
                    icon: AppIcons.imgMsg,
                    title: "Gallery",
                    onTap: () => controller.pickChatFile(FileType.media),
                  ),
                ),
                if ((getTicketStatusByLabel(
                            controller.mainTicket.status ?? "") !=
                        TicketStatus.Closed) &&
                    (getTicketStatusByLabel(
                            controller.mainTicket.status ?? "") !=
                        TicketStatus.Resolved))
                  SupportTextField(),
              ],
            ),
    );
  }
}

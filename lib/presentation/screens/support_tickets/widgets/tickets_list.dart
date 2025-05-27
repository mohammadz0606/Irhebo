import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/support_tickets/support_tickets_controller.dart';
import 'package:irhebo/presentation/screens/support_tickets/widgets/ticket_widget.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';
import 'package:irhebo/presentation/widgets/no_data.dart';

class TicketsList extends GetWidget<SupportTicketsController> {
  const TicketsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.98 * (w / 100)),
        child: controller.isLoading
            ? Column(
                children: [
                  for (int i = 0; i < 8; i++)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.49 * (w / 100)),
                      child: AppLoading(
                        height: 20.88 * (w / 100),
                        width: 100 * (w / 100),
                        radius: 12,
                      ),
                    )
                ],
              )
            : controller.tickets.isEmpty
                ? NoData(
                    forHome: false,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < controller.tickets.length; i++)
                        GestureDetector(
                          onTap: () => controller.onTapTicket(i),
                          child: TicketWidget(
                            ticket: controller.tickets[i],
                          ),
                        )
                    ],
                  ),
      ),
    );
  }
}

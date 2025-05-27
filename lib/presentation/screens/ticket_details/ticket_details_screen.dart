import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_functions.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/presentation/screens/chat/widgets/date_widget.dart';

import 'package:irhebo/presentation/screens/ticket_details/ticket_details_controller.dart';
import 'package:irhebo/presentation/screens/ticket_details/widgets/ticket_details_bottom_bar.dart';
import 'package:irhebo/presentation/screens/ticket_details/widgets/ticket_details_container.dart';
import 'package:irhebo/presentation/screens/ticket_details/widgets/ticket_response_card.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';

class TicketDetailsScreen extends GetView<TicketDetailsController> {
  const TicketDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Obx(
      () => Scaffold(
        appBar: NormalAppBar(
          title: controller.mainTicket.subject ?? "",
          onTapClose: () => controller.closeTicket(),
          isLoading: controller.isLoadingClose,
          isThereButton:
              ((getTicketStatusByLabel(controller.mainTicket.status ?? "") !=
                      TicketStatus.Closed) &&
                  (getTicketStatusByLabel(controller.mainTicket.status ?? "") !=
                      TicketStatus.Resolved)),
        ),
        body: controller.isLoading
            ? Center(child: CircularProgressIndicator())
            : GestureDetector(
                onTap: controller.reverse,
                child: SingleChildScrollView(
                  controller: controller.scrollController,
                  child: Padding(
                    padding: EdgeInsets.all(
                      3.98 * (w / 100),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TicketDetailsContainer(
                          ticket: controller.mainTicket,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 4.9 * (w / 100)),
                          child: Divider(
                            height: 2,
                          ),
                        ),
                        Obx(
                          () => Padding(
                            padding: EdgeInsets.only(bottom: 43 * (w / 100)),
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              reverse: true, // Newest messages at the bottom
                              itemCount:
                                  (controller.groupedTickets.keys.toList())
                                      .length,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Date Header
                                    DateWidget(
                                      forRequest: false,
                                      date: (controller.groupedTickets.keys
                                          .toList())[index],
                                    ),
                                    for (int i = 0;
                                        i <
                                            controller
                                                .groupedTickets[(controller
                                                    .groupedTickets.keys
                                                    .toList())[index]]!
                                                .reversed
                                                .toList()
                                                .length;
                                        i++)
                                      TicketResponseCard(
                                        onTapAttachment: (index) => controller
                                            .onTapAttachment(i, index),
                                        ticket: controller
                                            .groupedTickets[(controller
                                                .groupedTickets.keys
                                                .toList())[index]]!
                                            .reversed
                                            .toList()[i],
                                        user: controller
                                                .groupedTickets[(controller
                                                    .groupedTickets.keys
                                                    .toList())[index]]!
                                                .reversed
                                                .toList()[i]
                                                .isAdmin ==
                                            false,
                                      ),

                                    Container(
                                      height: 3.9 * (w / 100),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        bottomSheet: TicketDetailsBottomBar(),
      ),
    );
  }
}

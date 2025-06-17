import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/presentation/screens/support_tickets/support_tickets_controller.dart';
import 'package:irhebo/presentation/screens/support_tickets/widgets/tickets_list.dart';
import 'package:irhebo/presentation/widgets/add_button.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';

class SupportTicketsScreen extends GetView<SupportTicketsController> {
  const SupportTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const NormalAppBar(
        title: "Tickets",
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [TicketsList()],
        ),
      ),
      floatingActionButton: AddButton(
        onTap: () async => await Get.toNamed(AppRoutes.createTicket)?.then(
          (value) => controller.getTickets(),
        ),
      ),
    );
  }
}

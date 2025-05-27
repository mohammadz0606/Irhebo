import 'package:flutter/material.dart';
import 'package:irhebo/domain/models/ticket_model.dart';
import 'package:irhebo/presentation/screens/ticket_details/widgets/ticket_details_row.dart';

class TicketDetailsContainer extends StatelessWidget {
  final TicketModel ticket;
  const TicketDetailsContainer({
    super.key,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 3.98 * (w / 100), vertical: 1.99 * (w / 100)),
      child: Column(
        children: [
          TicketDetailsRow(
            title: "Subject",
            subtitle: ticket.subject ?? "",
          ),
          TicketDetailsRow(
            title: "Submitted",
            subtitle: ticket.createdAt ?? "",
          ),
          TicketDetailsRow(
            title: "Ticket ID",
            subtitle: ticket.id.toString(),
          ),
          TicketDetailsRow(
            title: "Ticket Status",
            subtitle: ticket.status ?? "",
          ),
        ],
      ),
    );
  }
}

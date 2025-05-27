import 'package:flutter/material.dart';
import 'package:irhebo/domain/models/notification_model.dart';
import 'package:irhebo/presentation/screens/notifications/widgets/notification_widget.dart';

class NotificationsTodayList extends StatelessWidget {
  final List<NotificationModel> notifications;
  final bool today;

  const NotificationsTodayList({
    super.key,
    required this.notifications,
    this.today = true,
  });

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < notifications.length; i++)
          Column(
            children: [
              NotificationWidget(
                notification: notifications[i],
              ),
              Divider(
                height: 1,
              )
            ],
          )
      ],
    );
  }
}

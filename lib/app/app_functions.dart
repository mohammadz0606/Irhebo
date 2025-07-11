// Helper function to format the date
import 'package:intl/intl.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/storage/app_prefs.dart';
import 'package:irhebo/app/storage/app_prefs_keys.dart';

import 'injection.dart';

String formatDate(DateTime date) {
  DateTime now = DateTime.now();
  if (date.year == now.year && date.month == now.month && date.day == now.day) {
    return "Today";
  } else if (date.year == now.year &&
      date.month == now.month &&
      date.day == now.day - 1) {
    return "Yesterday";
  } else {
    return "${date.day}/${date.month}/${date.year}";
  }
}

String formatTime(DateTime timestamp) {
  return DateFormat.jm().format(timestamp); // e.g., "2:30 PM"
}

String getChatTypeName(ChatsTabs type) {
  switch (type) {
    case ChatsTabs.All:
      return "All";
    case ChatsTabs.Spam:
      return "Spam";
    case ChatsTabs.Unread:
      return "Unread";
    case ChatsTabs.Starred:
      return "Starred";
    // default:
    //   return "Reach";
  }
}

FilterType getFilterTypeByLabel(String label) {
  switch (label) {
    case "checkbox":
      return FilterType.checkbox;
    case "rating":
      return FilterType.rating;
    case "range":
      return FilterType.range;
    case "number":
      return FilterType.number;
    case "dropdown_multiple":
      return FilterType.dropdown_multiple;
    case "dropdown":
      return FilterType.dropdown;
    default:
      return FilterType.dropdown;
  }
}

TicketStatus getTicketStatusByLabel(String label) {
  switch (label.toLowerCase()) {
    case "open":
      return TicketStatus.Open;
    case "pending":
      return TicketStatus.Pending;
    case "closed":
      return TicketStatus.Closed;
    case "resolved":
      return TicketStatus.Resolved;

    default:
      return TicketStatus.Open;
  }
}

UserRoles get getUserRole {
  AppPreferences prefs = sl();
  switch (prefs.getString(key: AppPrefsKeys.USER_ROLE)) {
    case 'freelancer':
      return UserRoles.freelancer;
    case 'client':
      return UserRoles.client;

    default:
      return UserRoles.non;
  }
}

NotificationType? notificationTypeFromString(String? type) {
  switch (type?.toLowerCase()) {
    case 'request':
      return NotificationType.request;
    case 'request_log':
      return NotificationType.requestLog;
    case 'new_freelancer':
      return NotificationType.newFreelancer;
    case 'rate':
      return NotificationType.rate;
    case 'quotation':
      return NotificationType.quotation;
    case 'chat':
      return NotificationType.chat;
    case 'call':
      return NotificationType.call;
    case 'verified':
      return NotificationType.verified;
    case 'support':
      return NotificationType.support;
    case 'service':
      return NotificationType.service;
    case 'portfolio':
      return NotificationType.portfolio;
    default:
      return null;
  }
}

ChatStatus? chatStatusFromString(String? type) {
  switch (type?.toLowerCase()) {
    case 'unread':
      return ChatStatus.unread;
    case 'stared':
      return ChatStatus.stared;
    case 'spam':
      return ChatStatus.spam;
    default:
      return ChatStatus.all;
  }
}

// Helper function to format the date
import 'package:intl/intl.dart';
import 'package:irhebo/app/enums.dart';

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

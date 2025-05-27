// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart' as dio;

class AddTicketResponseParams {
  final int? ticketId;
  final String? message;
  final List<dio.MultipartFile>? attachment;
  AddTicketResponseParams({
    this.ticketId,
    this.message,
    this.attachment,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (attachment != null) 'attachment[]': attachment,
      if (message != null) 'message': message,
      if (ticketId != null) 'ticket_id': ticketId,
    };
  }
}

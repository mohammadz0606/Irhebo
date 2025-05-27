// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart' as dio;

class CreateTicketParams {
  final String? subject;
  final String? message;
  final int? requestId;
  final List<dio.MultipartFile>? attachment;
  CreateTicketParams({
    this.subject,
    this.message,
    this.requestId,
    this.attachment,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (attachment != null) 'attachment[]': attachment,
      if (subject != null) 'subject': subject,
      if (message != null) 'message': message,
      if (requestId != null) 'request_id': requestId,
    };
  }
}

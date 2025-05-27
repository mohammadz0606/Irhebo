// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart' as dio;

class UpdateRequestParams {
  final int? requestId;
  final String? status;
  final String? action;
  final List<dio.MultipartFile>? attachments;
  UpdateRequestParams({
    this.requestId,
    this.status,
    this.action,
    this.attachments,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (requestId != null) 'request_id': requestId,
      if (status != null) 'status': status,
      if (action != null) 'action': action,
      if (attachments != null) 'attachments[]': attachments,
    };
  }
}

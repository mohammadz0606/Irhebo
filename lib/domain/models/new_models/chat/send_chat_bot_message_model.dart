import 'dart:developer';

import 'package:intl/intl.dart';

class SendBotMessageModel {

  bool? success;
  String? message;
  SendBotMessageModelData? data;

  SendBotMessageModel({
    this.success,
    this.message,
    this.data,
  });
  SendBotMessageModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message']?.toString();
    data = (json['data'] != null) ? SendBotMessageModelData.fromJson(json['data']) : null;
  }
}


class SendBotMessageModelData {

  int? userId;
  String? message;
  String? role;
  String? type;
  String? updatedAt;
  DateTime? createdAt;
  int? id;

  SendBotMessageModelData({
    this.userId,
    this.message,
    this.role,
    this.type,
    this.updatedAt,
    this.createdAt,
    this.id,
  });
  SendBotMessageModelData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id']?.toInt();
    message = json['message']?.toString();
    role = json['role']?.toString();
    type = json['type']?.toString();
    updatedAt = json['updated_at']?.toString();
    final dateString = json['created_at']?.toString();
    if (dateString != null) {
      try {
        createdAt = DateFormat('EEE, MMM d, yyyy h:mm a', 'en_US').parse(dateString);
      } catch (e) {
        log('Date parsing error: $e | value = $dateString');
        createdAt = DateTime.now();
      }
    }
    id = json['id']?.toInt();
  }

}


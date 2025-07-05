import 'dart:developer';

import 'package:intl/intl.dart';

class ChatMessagesModel {
  bool? status;
  String? message;
  ChatMessagesModelData? data;

  ChatMessagesModel({
    this.status,
    this.message,
    this.data,
  });

  ChatMessagesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = (json['data'] != null)
        ? ChatMessagesModelData.fromJson(json['data'])
        : null;
  }
}

class ChatMessagesModelDataMessages {
  int? id;
  String? message;
  String? attachmentUrl;
  String? attachmentType;
  int? isRead;
  DateTime? createdAt;
  ChatMessagesModelDataMessagesSender? sender;
  ChatMessagesModelDataMessagesReceiver? receiver;

  ChatMessagesModelDataMessages({
    this.id,
    this.message,
    this.attachmentUrl,
    this.attachmentType,
    this.isRead,
    this.createdAt,
    this.sender,
    this.receiver,
  });

  ChatMessagesModelDataMessages.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    message = json['message']?.toString();
    attachmentUrl = json['attachment_url']?.toString();
    attachmentType = json['attachment_type']?.toString();
    isRead = json['is_read']?.toInt();
    final dateString = json['created_at']?.toString();
    if (dateString != null) {
      try {
        createdAt = DateFormat('EEE, MMM d, yyyy h:mm a', 'en_US').parse(dateString);
      } catch (e) {
        log('Date parsing error: $e | value = $dateString');
        createdAt = DateTime.now();
      }
    }
    // createdAt = DateTime.parse(
    //     json['created_at']?.toString() ?? DateTime.now().toString());
    sender = (json['sender'] != null)
        ? ChatMessagesModelDataMessagesSender.fromJson(json['sender'])
        : null;
    receiver = (json['receiver'] != null)
        ? ChatMessagesModelDataMessagesReceiver.fromJson(json['receiver'])
        : null;
  }

  ChatMessagesModelDataMessages.fromJsonNew(Map<String, dynamic> json) {
    isRead = json['is_read'] == false ? 0 : 1;
    id = json['id']?.toInt();
    message = json['message']?.toString();
    attachmentUrl = json['attachment_url']?.toString();
    attachmentType = json['attachment_type']?.toString();
    final dateString = json['created_at']?.toString();
    if (dateString != null) {
      try {
        createdAt = DateFormat('EEE, MMM d, yyyy h:mm a', 'en_US').parse(dateString);
      } catch (e) {
        log('Date parsing error: $e | value = $dateString');
        createdAt = DateTime.now();
      }
    }
    sender = (json['sender'] != null)
        ? ChatMessagesModelDataMessagesSender.fromJson(json['sender'])
        : null;
    receiver = (json['receiver'] != null)
        ? ChatMessagesModelDataMessagesReceiver.fromJson(json['receiver'])
        : null;
  }
}

class ChatMessagesModelDataMessagesReceiver {
  int? id;
  String? username;
  String? avatar;

  ChatMessagesModelDataMessagesReceiver({
    this.id,
    this.username,
    this.avatar,
  });

  ChatMessagesModelDataMessagesReceiver.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    username = json['username']?.toString();
    avatar = json['avatar']?.toString();
  }
}

class ChatMessagesModelDataMessagesSender {
  int? id;
  String? username;
  String? avatar;

  ChatMessagesModelDataMessagesSender({
    this.id,
    this.username,
    this.avatar,
  });

  ChatMessagesModelDataMessagesSender.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    username = json['username']?.toString();
    avatar = json['avatar']?.toString();
  }
}

class ChatMessagesModelDataReceiver {
  int? id;
  String? username;
  String? avatar;

  ChatMessagesModelDataReceiver({
    this.id,
    this.username,
    this.avatar,
  });

  ChatMessagesModelDataReceiver.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    username = json['username']?.toString();
    avatar = json['avatar']?.toString();
  }
}

class ChatMessagesModelDataSender {
  int? id;
  String? username;
  String? avatar;

  ChatMessagesModelDataSender({
    this.id,
    this.username,
    this.avatar,
  });

  ChatMessagesModelDataSender.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    username = json['username']?.toString();
    avatar = json['avatar']?.toString();
  }
}

class ChatMessagesModelData {
  ChatMessagesModelDataSender? sender;
  ChatMessagesModelDataReceiver? receiver;
  List<ChatMessagesModelDataMessages>? messages;

  ChatMessagesModelData({
    this.sender,
    this.receiver,
    this.messages,
  });

  ChatMessagesModelData.fromJson(Map<String, dynamic> json) {
    sender = (json['sender'] != null)
        ? ChatMessagesModelDataSender.fromJson(json['sender'])
        : null;
    receiver = (json['receiver'] != null)
        ? ChatMessagesModelDataReceiver.fromJson(json['receiver'])
        : null;
    if (json['messages'] != null) {
      final v = json['messages'];
      final arr0 = <ChatMessagesModelDataMessages>[];
      v.forEach((v) {
        arr0.add(ChatMessagesModelDataMessages.fromJson(v));
      });
      messages = arr0;
    }
  }
}

final class ChatAppbar {
  int? id;
  String? username;
  String? avatar;

  ChatAppbar({
    this.id,
    this.username,
    this.avatar,
  });
}

class ChatMessagesModel {
  bool? status;
  String? message;
  List<ChatMessagesModelData>? data;

  ChatMessagesModel({
    this.status,
    this.message,
    this.data,
  });

  ChatMessagesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <ChatMessagesModelData>[];
      v.forEach((v) {
        arr0.add(ChatMessagesModelData.fromJson(v));
      });
      data = arr0;
    }
  }
}

class ChatMessagesModelData {
  int? id;
  String? message;
  String? attachmentUrl;
  String? attachmentType;
  int? isRead;
  DateTime? createdAt;
  ChatMessagesModelDataSender? sender;
  ChatMessagesModelDataReceiver? receiver;

  ChatMessagesModelData({
    this.id,
    this.message,
    this.attachmentUrl,
    this.attachmentType,
    this.isRead,
    this.createdAt,
    this.sender,
    this.receiver,
  });

  ChatMessagesModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    message = json['message']?.toString();
    attachmentUrl = json['attachment_url']?.toString();
    attachmentType = json['attachment_type']?.toString();
    isRead = json['is_read']?.toInt();
    createdAt = DateTime.parse(
        json['created_at']?.toString() ?? DateTime.now().toString());
    sender = (json['sender'] != null)
        ? ChatMessagesModelDataSender.fromJson(json['sender'])
        : null;
    receiver = (json['receiver'] != null)
        ? ChatMessagesModelDataReceiver.fromJson(json['receiver'])
        : null;
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

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
  String? createdAt;
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
    createdAt = json['created_at']?.toString();
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

  ChatMessagesModelDataSender({
    this.id,
    this.username,
  });

  ChatMessagesModelDataSender.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    username = json['username']?.toString();
  }
}

class ChatMessagesModelDataReceiver {
  int? id;
  String? username;

  ChatMessagesModelDataReceiver({
    this.id,
    this.username,
  });

  ChatMessagesModelDataReceiver.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    username = json['username']?.toString();
  }
}

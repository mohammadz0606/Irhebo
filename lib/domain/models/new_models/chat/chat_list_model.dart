class ChatListModel {


  bool? status;
  String? message;
  List<ChatListModelData>? data;

  ChatListModel({
    this.status,
    this.message,
    this.data,
  });
  ChatListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <ChatListModelData>[];
      v.forEach((v) {
        arr0.add(ChatListModelData.fromJson(v));
      });
      data = arr0;
    }
  }

}



class ChatListModelDataLastMessage {
  int? id;
  int? chatId;
  int? senderId;
  String? message;
  String? attachmentUrl;
  String? attachmentType;
  int? isRead;
  String? createdAt;
  String? updatedAt;

  ChatListModelDataLastMessage({
    this.id,
    this.chatId,
    this.senderId,
    this.message,
    this.attachmentUrl,
    this.attachmentType,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  });
  ChatListModelDataLastMessage.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    chatId = json['chat_id']?.toInt();
    senderId = json['sender_id']?.toInt();
    message = json['message']?.toString();
    attachmentUrl = json['attachment_url']?.toString();
    attachmentType = json['attachment_type']?.toString();
    isRead = json['is_read']?.toInt();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }

}

class ChatListModelDataReceiver {


  int? id;
  String? username;
  String? image;

  ChatListModelDataReceiver({
    this.id,
    this.username,
    this.image,
  });
  ChatListModelDataReceiver.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    username = json['username']?.toString();
    image = json['image']?.toString();
  }

}

class ChatListModelData {

  int? chatId;
  String? chatStatus;
  ChatListModelDataReceiver? receiver;
  int? unreadCount;
  ChatListModelDataLastMessage? lastMessage;

  ChatListModelData({
    this.chatId,
    this.chatStatus,
    this.receiver,
    this.unreadCount,
    this.lastMessage,
  });
  ChatListModelData.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id']?.toInt();
    chatStatus = json['chat_status']?.toString();
    receiver = (json['receiver'] != null) ? ChatListModelDataReceiver.fromJson(json['receiver']) : null;
    unreadCount = json['unread_count']?.toInt();
    lastMessage = (json['last_message'] != null) ? ChatListModelDataLastMessage.fromJson(json['last_message']) : null;
  }

}


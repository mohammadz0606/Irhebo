class EndCallModel {
  bool? status;
  String? message;
  EndCallModelData? data;

  EndCallModel({
    this.status,
    this.message,
    this.data,
  });

  EndCallModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data =
    (json['data'] != null) ? EndCallModelData.fromJson(json['data']) : null;
  }
}



class EndCallModelDataMessage {
  int? chatId;
  int? senderId;
  String? message;
  String? attachmentUrl;
  String? attachmentType;
  bool? isRead;
  String? updatedAt;
  String? createdAt;
  int? id;

  EndCallModelDataMessage({
    this.chatId,
    this.senderId,
    this.message,
    this.attachmentUrl,
    this.attachmentType,
    this.isRead,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  EndCallModelDataMessage.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id']?.toInt();
    senderId = json['sender_id']?.toInt();
    message = json['message']?.toString();
    attachmentUrl = json['attachment_url']?.toString();
    attachmentType = json['attachment_type']?.toString();
    isRead = json['is_read'];
    updatedAt = json['updated_at']?.toString();
    createdAt = json['created_at']?.toString();
    id = json['id']?.toInt();
  }
}

class EndCallModelDataCall {
  int? id;
  int? callerId;
  int? receiverId;
  String? channelName;
  String? startedAt;
  String? endedAt;
  String? createdAt;
  String? updatedAt;

  EndCallModelDataCall({
    this.id,
    this.callerId,
    this.receiverId,
    this.channelName,
    this.startedAt,
    this.endedAt,
    this.createdAt,
    this.updatedAt,
  });

  EndCallModelDataCall.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    callerId = json['caller_id']?.toInt();
    receiverId = json['receiver_id']?.toInt();
    channelName = json['channel_name']?.toString();
    startedAt = json['started_at']?.toString();
    endedAt = json['ended_at']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }
}

class EndCallModelData {
  EndCallModelDataCall? call;
  EndCallModelDataMessage? message;

  EndCallModelData({
    this.call,
    this.message,
  });

  EndCallModelData.fromJson(Map<String, dynamic> json) {
    call = (json['call'] != null)
        ? EndCallModelDataCall.fromJson(json['call'])
        : null;
    message = (json['message'] != null)
        ? EndCallModelDataMessage.fromJson(json['message'])
        : null;
  }
}


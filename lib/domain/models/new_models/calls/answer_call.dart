class AnswerCallModel {
  bool? status;
  String? message;
  AnswerCallModelData? data;

  AnswerCallModel({
    this.status,
    this.message,
    this.data,
  });

  AnswerCallModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = (json['data'] != null)
        ? AnswerCallModelData.fromJson(json['data'])
        : null;
  }
}

class AnswerCallModelData {
  int? id;
  int? callerId;
  int? receiverId;
  String? channelName;
  String? startedAt;
  String? endedAt;
  String? createdAt;
  String? updatedAt;

  AnswerCallModelData({
    this.id,
    this.callerId,
    this.receiverId,
    this.channelName,
    this.startedAt,
    this.endedAt,
    this.createdAt,
    this.updatedAt,
  });

  AnswerCallModelData.fromJson(Map<String, dynamic> json) {
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

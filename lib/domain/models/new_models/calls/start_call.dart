class StartCallModel {
  bool? status;
  String? message;
  StartCallModelData? data;

  StartCallModel({
    this.status,
    this.message,
    this.data,
  });

  StartCallModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = (json['data'] != null)
        ? StartCallModelData.fromJson(json['data'])
        : null;
  }
}

class StartCallModelData {
  String? token;
  StartCallModelDataCall? call;

  StartCallModelData({
    this.token,
    this.call,
  });

  StartCallModelData.fromJson(Map<String, dynamic> json) {
    token = json['token']?.toString();
    call = (json['call'] != null)
        ? StartCallModelDataCall.fromJson(json['call'])
        : null;
  }
}

class StartCallModelDataCall {
  int? id;
  int? callerId;
  int? receiverId;
  String? channelName;
  String? startedAt;
  String? endedAt;
  String? createdAt;
  String? updatedAt;

  StartCallModelDataCall({
    this.id,
    this.callerId,
    this.receiverId,
    this.channelName,
    this.startedAt,
    this.endedAt,
    this.createdAt,
    this.updatedAt,
  });

  StartCallModelDataCall.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    callerId = json['caller_id']?.toInt();
    receiverId = int.parse(json['receiver_id']?.toString() ?? '0');
    channelName = json['channel_name']?.toString();
    startedAt = json['started_at']?.toString();
    endedAt = json['ended_at']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:irhebo/domain/models/home_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irhebo/domain/models/login_model.dart';

part 'ticket_model.g.dart';

@JsonSerializable()
class TicketModel {
  int? id;
  String? subject;
  String? status;
  @JsonKey(name: 'created_at')
  String? createdAt;
  UserModel? user;
  @JsonKey(name: 'ticket_id')
  int? ticketId;
  String? message;
  @JsonKey(name: 'request_title')
  String? requestTitle;
  @JsonKey(name: 'is_admin')
  bool? isAdmin;
  SenderModel? sender;
  List<MediaModel>? attachments;

  TicketModel({
    this.id,
    this.subject,
    this.status,
    this.createdAt,
    this.requestTitle,
    this.user,
    this.ticketId,
    this.message,
    this.isAdmin,
    this.sender,
    this.attachments,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return _$TicketModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TicketModelToJson(this);
}

@JsonSerializable()
class SenderModel {
  int? id;
  @JsonKey(name: 'username')
  String? username;
  String? avatar;
  SenderModel({
    this.id,
    this.username,
    this.avatar,
  });

  factory SenderModel.fromJson(Map<String, dynamic> json) {
    return _$SenderModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SenderModelToJson(this);
}

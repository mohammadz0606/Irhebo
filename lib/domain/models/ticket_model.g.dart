// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketModel _$TicketModelFromJson(Map<String, dynamic> json) => TicketModel(
      id: (json['id'] as num?)?.toInt(),
      subject: json['subject'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      requestTitle: json['request_title'] as String?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      ticketId: (json['ticket_id'] as num?)?.toInt(),
      message: json['message'] as String?,
      isAdmin: json['is_admin'] as bool?,
      sender: json['sender'] == null
          ? null
          : SenderModel.fromJson(json['sender'] as Map<String, dynamic>),
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TicketModelToJson(TicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'status': instance.status,
      'created_at': instance.createdAt,
      'user': instance.user,
      'ticket_id': instance.ticketId,
      'message': instance.message,
      'request_title': instance.requestTitle,
      'is_admin': instance.isAdmin,
      'sender': instance.sender,
      'attachments': instance.attachments,
    };

SenderModel _$SenderModelFromJson(Map<String, dynamic> json) => SenderModel(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'] as String?,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$SenderModelToJson(SenderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatar': instance.avatar,
    };

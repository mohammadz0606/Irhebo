// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: (json['id'] as num?)?.toInt(),
      type: notificationTypeFromString(json['type'] as String?),
      typeId: json['type_id'] as String?,
      isRead: (json['is_read'] as num?)?.toInt(),
      title: json['title'] as String?,
      body: json['body'] as String?,
      createdAt: json['created_at'] as String?,
    );

PaginatedNotificationsModel _$PaginatedNotificationsModelFromJson(
        Map<String, dynamic> json) =>
    PaginatedNotificationsModel(
      notifications: (json['notifications'] as List<dynamic>?)
          ?.map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaginatedNotificationsModelToJson(
        PaginatedNotificationsModel instance) =>
    <String, dynamic>{
      'notifications': instance.notifications,
      'meta': instance.meta,
    };

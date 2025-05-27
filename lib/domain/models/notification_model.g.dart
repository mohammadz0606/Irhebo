// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: (json['id'] as num?)?.toInt(),
      action: json['action'] as String?,
      actionId: json['action_id'] as String?,
      icon: json['icon'] as String?,
      isGeneral: json['is_general'] as bool?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'action': instance.action,
      'action_id': instance.actionId,
      'icon': instance.icon,
      'is_general': instance.isGeneral,
      'title': instance.title,
      'description': instance.description,
      'created_at': instance.createdAt,
    };

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

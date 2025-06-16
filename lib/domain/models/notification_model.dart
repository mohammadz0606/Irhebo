// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:irhebo/domain/models/config_model.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  int? id;
  String? type;
  @JsonKey(name: 'type_id')
  String? typeId;
  @JsonKey(name: 'is_read')
  int? isRead;
  String? title;
  String? body;
  @JsonKey(name: 'created_at')
  String? createdAt;
  NotificationModel({
    this.id,
    this.typeId,
    this.type,
    this.isRead,
    this.title,
    this.body,
    this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return _$NotificationModelFromJson(json);
  }

}

@JsonSerializable()
class PaginatedNotificationsModel {
  List<NotificationModel>? notifications;
  MetaModel? meta;
  PaginatedNotificationsModel({
    this.notifications,
    this.meta,
  });

  factory PaginatedNotificationsModel.fromJson(Map<String, dynamic> json) {
    return _$PaginatedNotificationsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaginatedNotificationsModelToJson(this);
}

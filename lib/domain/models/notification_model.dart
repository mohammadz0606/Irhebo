// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:irhebo/domain/models/config_model.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  int? id;
  String? action;
  @JsonKey(name: 'action_id')
  String? actionId;
  String? icon;
  @JsonKey(name: 'is_general')
  bool? isGeneral;
  String? title;
  String? description;
  @JsonKey(name: 'created_at')
  String? createdAt;
  NotificationModel({
    this.id,
    this.action,
    this.actionId,
    this.icon,
    this.isGeneral,
    this.title,
    this.description,
    this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return _$NotificationModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
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

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/domain/models/login_model.dart';
import 'package:irhebo/domain/models/service_details_model.dart';

part 'request_model.g.dart';

@JsonSerializable()
class RequestModel {
  int? id;
  String? title;
  String? image;
  @JsonKey(name: 'order_number')
  String? orderNumber;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'created_since')
  String? createdSince;
  @JsonKey(name: 'status_label')
  String? statusLabel;
  @JsonKey(name: 'status_key')
  String? statusKey;
  @JsonKey(name: 'is_reviewed')
  bool? isReviewed;
  UserModel? user;
  ServiceModel? service;
  PlanModel? plan;
  List<LogModel>? logs;
  @JsonKey(name: 'image_url')
  String? imageUrl;
  @JsonKey(name: 'start_date')
  String? startDate;
  @JsonKey(name: 'end_date')
  String? endDate;
  @JsonKey(name: 'elapsed_days')
  int? elapsedDays;
  @JsonKey(name: 'total_days')
  int? totalDays;
  @JsonKey(name: 'need_action')
  bool? needAction;
  @JsonKey(name: 'progress_percentage')
  int? progressPercentage;
  RequestModel({
    this.id,
    this.title,
    this.image,
    this.orderNumber,
    this.createdAt,
    this.createdSince,
    this.statusLabel,
    this.statusKey,
    this.isReviewed,
    this.user,
    this.needAction,
    this.service,
    this.plan,
    this.logs,
    this.imageUrl,
    this.startDate,
    this.endDate,
    this.elapsedDays,
    this.totalDays,
    this.progressPercentage,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return _$RequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RequestModelToJson(this);
}

@JsonSerializable()
class LogModel {
  int? id;
  @JsonKey(name: 'request_id')
  int? requestId;
  String? action;
  @JsonKey(name: 'created_at')
  String? createdAt;
  UserModel? user;
  LogModel({
    this.id,
    this.requestId,
    this.action,
    this.createdAt,
    this.user,
  });

  factory LogModel.fromJson(Map<String, dynamic> json) {
    return _$LogModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LogModelToJson(this);
}

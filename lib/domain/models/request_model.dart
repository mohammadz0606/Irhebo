// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';

import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/domain/models/login_model.dart';
import 'package:irhebo/domain/models/service_details_model.dart';

import 'new_models/freelancer/freelancer_user.dart';

part 'request_model.g.dart';

@JsonSerializable()
class RequestModel {
  int? id;
  String? title;
  String? image;
  @JsonKey(name: 'order_number')
  String? orderNumber;
  @JsonKey(name: 'contract_path')
  String? contractPath;
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
  FreelancerDataModel? freelancer;
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
    this.contractPath,
    this.freelancer,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    log('ALL JSON');
    log(json.toString());
    return _$RequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RequestModelToJson(this);
}


class FreelancerDataModel {
  int? id;
  String? name;
  String? email;
  String? fullPhone;
  String? phone;
  String? prefix;
  String? gender;
  String? avatar;
  String? role;
  String? bio;
  String? profession;
  List<LanguageModel>? languages;

  FreelancerDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    email = json['email']?.toString();
    fullPhone = json['full_phone']?.toString();
    prefix = json['prefix']?.toString();
    phone = json['phone']?.toString();
    gender = json['gender']?.toString();
    avatar = json['avatar']?.toString();
    role = json['role']?.toString();
    bio = json['bio']?.toString();
    profession = json['profession']?.toString();

    if (json['languages'] != null) {
      final v = json['languages'];
      final arr0 = <LanguageModel>[];
      v.forEach((v) {
        arr0.add(LanguageModel.fromJson(v));
      });
      languages = arr0;
    }
  }

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
  List<AttachmentModel>? attachments;

  LogModel(
      {this.id,
      this.requestId,
      this.action,
      this.createdAt,
      this.user,
      this.attachments});

  factory LogModel.fromJson(Map<String, dynamic> json) {
    return _$LogModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LogModelToJson(this);
}

@JsonSerializable()
class AttachmentModel {
  int? id;

  @JsonKey(name: 'media_path')
  String? mediaPath;

  @JsonKey(name: 'media_type')
  String? mediaType;

  AttachmentModel({this.id, this.mediaPath, this.mediaType});

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$AttachmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentModelToJson(this);
}

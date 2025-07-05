// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestModel _$RequestModelFromJson(Map<String, dynamic> json) => RequestModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      image: json['image'] as String?,
      orderNumber: json['order_number'] as String?,
      contractPath: json['contract_path'] as String?,
      createdAt: json['created_at'] as String?,
      createdSince: json['created_since'] as String?,
      statusLabel: json['status_label'] as String?,
      statusKey: json['status_key'] as String?,
      isReviewed: json['is_reviewed'] as bool?,
      // "created_at": "Fri, Jul 4, 2025 10:45 AM"
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      freelancer: json['freelancer_user'] == null
          ? null
          : UserFreelancerModelDataFreelancer.fromJson(json['freelancer_user'] as Map<String, dynamic>),
      needAction: json['need_action'] as bool?,
      service: json['service'] == null
          ? null
          : ServiceModel.fromJson(json['service'] as Map<String, dynamic>),
      plan: json['plan'] == null
          ? null
          : PlanModel.fromJson(json['plan'] as Map<String, dynamic>),
      logs: (json['logs'] as List<dynamic>?)
          ?.map((e) => LogModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      imageUrl: json['image_url'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      elapsedDays: (json['elapsed_days'] as num?)?.toInt(),
      totalDays: (json['total_days'] as num?)?.toInt(),
      progressPercentage: (json['progress_percentage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RequestModelToJson(RequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'order_number': instance.orderNumber,
      'created_at': instance.createdAt,
      'created_since': instance.createdSince,
      'status_label': instance.statusLabel,
      'status_key': instance.statusKey,
      'is_reviewed': instance.isReviewed,
      'user': instance.user,
      'service': instance.service,
      'plan': instance.plan,
      'logs': instance.logs,
      'image_url': instance.imageUrl,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'elapsed_days': instance.elapsedDays,
      'total_days': instance.totalDays,
      'need_action': instance.needAction,
      'progress_percentage': instance.progressPercentage,
    };

LogModel _$LogModelFromJson(Map<String, dynamic> json) => LogModel(
      id: (json['id'] as num?)?.toInt(),
      requestId: (json['request_id'] as num?)?.toInt(),
      action: json['action'] as String?,
      createdAt: json['created_at'] as String?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      attachments: json['attachments'] == null
          ? null
          : (json['attachments'] as List)
              .map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$LogModelToJson(LogModel instance) => <String, dynamic>{
      'id': instance.id,
      'request_id': instance.requestId,
      'action': instance.action,
      'created_at': instance.createdAt,
      'user': instance.user,
    };

AttachmentModel _$AttachmentModelFromJson(Map<String, dynamic> json) =>
    AttachmentModel(
      id: json['id'] as int?,
      mediaPath: json['media_path'] as String?,
      mediaType: json['media_type'] as String?,
    );

Map<String, dynamic> _$AttachmentModelToJson(AttachmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'media_path': instance.mediaPath,
      'media_type': instance.mediaType,
    };

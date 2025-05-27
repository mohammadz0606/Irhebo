// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceDetailsModel _$ServiceDetailsModelFromJson(Map<String, dynamic> json) =>
    ServiceDetailsModel(
      service: json['service'] == null
          ? null
          : ServiceModel.fromJson(json['service'] as Map<String, dynamic>),
      portoflio: (json['portoflio'] as List<dynamic>?)
          ?.map((e) => DataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommended: (json['recommended'] as List<dynamic>?)
          ?.map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      plans: (json['plans'] as List<dynamic>?)
          ?.map((e) => PlanModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServiceDetailsModelToJson(
        ServiceDetailsModel instance) =>
    <String, dynamic>{
      'service': instance.service,
      'portoflio': instance.portoflio,
      'reviews': instance.reviews,
      'recommended': instance.recommended,
      'plans': instance.plans,
    };

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      id: (json['id'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toInt(),
      comment: json['comment'] as String?,
      createdAt: json['created_at'] as String?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      show: json['show'] as bool? ?? false,
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rating': instance.rating,
      'comment': instance.comment,
      'created_at': instance.createdAt,
      'user': instance.user,
      'show': instance.show,
    };

PlanModel _$PlanModelFromJson(Map<String, dynamic> json) => PlanModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      price: json['price'] as String?,
      deliveryDays: (json['delivery_days'] as num?)?.toInt(),
      features: (json['features'] as List<dynamic>?)
          ?.map((e) => FeatureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlanModelToJson(PlanModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'delivery_days': instance.deliveryDays,
      'features': instance.features,
    };

FeatureModel _$FeatureModelFromJson(Map<String, dynamic> json) => FeatureModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$FeatureModelToJson(FeatureModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'value': instance.value,
    };

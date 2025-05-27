// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutModel _$CheckoutModelFromJson(Map<String, dynamic> json) =>
    CheckoutModel(
      id: json['id'] as String?,
      description: json['description'] as String?,
      subTotal: json['sub_total'] as String?,
      tax: json['tax'] as String?,
      total: json['total'] as String?,
      title: json['title'] as String?,
      planTitle: json['plan_title'] as String?,
    );

Map<String, dynamic> _$CheckoutModelToJson(CheckoutModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'sub_total': instance.subTotal,
      'tax': instance.tax,
      'total': instance.total,
      'title': instance.title,
      'plan_title': instance.planTitle,
    };

CheckoutServiceModel _$CheckoutServiceModelFromJson(
        Map<String, dynamic> json) =>
    CheckoutServiceModel(
      service: json['request_info'] == null
          ? null
          : CheckoutModel.fromJson(
              json['request_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckoutServiceModelToJson(
        CheckoutServiceModel instance) =>
    <String, dynamic>{
      'request_info': instance.service,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SliderModel _$SliderModelFromJson(Map<String, dynamic> json) => SliderModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      buttonAction: json['button_action'] as String?,
      buttonText: json['button_text'] as String?,
      mediaPath: json['media_path'] as String?,
      mediaType: json['media_type'] as String?,
    );

Map<String, dynamic> _$SliderModelToJson(SliderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'buttonAction': instance.buttonAction,
      'buttonText': instance.buttonText,
      'mediaPath': instance.mediaPath,
      'mediaType': instance.mediaType,
    };

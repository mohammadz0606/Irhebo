// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaqModel _$FaqModelFromJson(Map<String, dynamic> json) => FaqModel(
      id: (json['id'] as num?)?.toInt(),
      question: json['question'] as String?,
      answer: json['answer'] as String?,
      mediaPath: json['media_path'] as String?,
      visible: json['visible'] as bool? ?? false,
      mediaType: json['media_type'] as String?,
    );

Map<String, dynamic> _$FaqModelToJson(FaqModel instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answer': instance.answer,
      'media_path': instance.mediaPath,
      'media_type': instance.mediaType,
      'visible': instance.visible,
    };

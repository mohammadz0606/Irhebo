// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigModel _$ConfigModelFromJson(Map<String, dynamic> json) => ConfigModel(
      professions: (json['professions'] as List<dynamic>?)
          ?.map((e) => ProfessionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      countries: json['countries'] == null
          ? null
          : PaginationModel.fromJson(json['countries'] as Map<String, dynamic>),
      languages: json['languages'] == null
          ? null
          : PaginationModel.fromJson(json['languages'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConfigModelToJson(ConfigModel instance) =>
    <String, dynamic>{
      'professions': instance.professions,
      'countries': instance.countries,
      'languages': instance.languages,
    };

ProfessionModel _$ProfessionModelFromJson(Map<String, dynamic> json) =>
    ProfessionModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$ProfessionModelToJson(ProfessionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

DataModel _$DataModelFromJson(Map<String, dynamic> json) => DataModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      flag: json['flag'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      cover: json['cover'] == null
          ? null
          : MediaModel.fromJson(json['cover'] as Map<String, dynamic>),
      description: json['description'] as String?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      media: (json['media'] as List<dynamic>?)
          ?.map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataModelToJson(DataModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'flag': instance.flag,
      'user_id': instance.userId,
      'description': instance.description,
      'cover': instance.cover,
      'user': instance.user,
      'media': instance.media,
    };

MetaModel _$MetaModelFromJson(Map<String, dynamic> json) => MetaModel(
      currentPage: (json['current_page'] as num?)?.toInt(),
      lastPage: (json['last_page'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MetaModelToJson(MetaModel instance) => <String, dynamic>{
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'per_page': instance.perPage,
      'total': instance.total,
    };

LevelModel _$LevelModelFromJson(Map<String, dynamic> json) => LevelModel(
      key: json['key'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$LevelModelToJson(LevelModel instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
    };

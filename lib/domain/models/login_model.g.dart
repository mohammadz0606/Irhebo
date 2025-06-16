// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      fullPhone: json['full_phone'] as String?,
      prefix: json['prefix'] as String?,
      phone: json['phone'] as String?,
      gender: json['gender'] as String?,
      profession: json['profession'] as String?,
      isNotifiable: (json['is_notifiable'] as num?)?.toInt(),
      professionObject: json['profession_object'] == null
          ? null
          : ProfessionModel.fromJson(
              json['profession_object'] as Map<String, dynamic>),
      country: json['country'] as String?,
      countryObject: json['country_object'] == null
          ? null
          : DataModel.fromJson(json['country_object'] as Map<String, dynamic>),
      username: json['username'] as String?,
      avatar: json['avatar'] as String?,
      role: json['role'] as String?,
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => LanguageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'full_phone': instance.fullPhone,
      'prefix': instance.prefix,
      'phone': instance.phone,
      'gender': instance.gender,
      'profession': instance.profession,
      'profession_object': instance.professionObject,
      'country': instance.country,
      'country_object': instance.countryObject,
      'username': instance.username,
      'avatar': instance.avatar,
      'role': instance.role,
      'languages': instance.languages,
    };

LanguageModel _$LanguageModelFromJson(Map<String, dynamic> json) =>
    LanguageModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      flag: json['flag'] as String?,
      level: json['level'] as String?,
    );

Map<String, dynamic> _$LanguageModelToJson(LanguageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'flag': instance.flag,
      'level': instance.level,
    };

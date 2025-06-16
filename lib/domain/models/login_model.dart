// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

import 'package:irhebo/domain/models/config_model.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  UserModel? user;
  String? token;
  LoginModel({
    this.user,
    this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return _$LoginModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

@JsonSerializable()
class UserModel {
  int? id;
  String? name;
  String? email;
  @JsonKey(name: 'full_phone')
  String? fullPhone;
  String? prefix;
  String? phone;
  String? gender;
  String? profession;
  @JsonKey(name: 'profession_object')
  ProfessionModel? professionObject;
  String? country;
  @JsonKey(name: 'country_object')
  DataModel? countryObject;
  String? username;
  String? avatar;
  String? role;
  @JsonKey(name: 'is_notifiable')
  int? isNotifiable;
  List<LanguageModel>? languages;
  UserModel({
    this.id,
    this.name,
    this.email,
    this.fullPhone,
    this.prefix,
    this.phone,
    this.gender,
    this.profession,
    this.professionObject,
    this.country,
    this.countryObject,
    this.username,
    this.avatar,
    this.role,
    this.languages,
    this.isNotifiable,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class LanguageModel {
  int? id;
  String? title;
  String? flag;
  String? level;
  LanguageModel({
    this.id,
    this.title,
    this.flag,
    this.level,
  });
  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return _$LanguageModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LanguageModelToJson(this);
}

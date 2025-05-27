// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:irhebo/domain/models/freelancer_details_model.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irhebo/domain/models/login_model.dart';

part 'config_model.g.dart';

@JsonSerializable()
class ConfigModel {
  List<ProfessionModel>? professions;
  PaginationModel? countries;
  PaginationModel? languages;
  ConfigModel({
    this.professions,
    this.countries,
    this.languages,
  });
  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return _$ConfigModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ConfigModelToJson(this);
}

@JsonSerializable()
class ProfessionModel {
  int? id;
  String? title;
  ProfessionModel({
    this.id,
    this.title,
  });

  factory ProfessionModel.fromJson(Map<String, dynamic> json) {
    return _$ProfessionModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfessionModelToJson(this);
}

@JsonSerializable()
class DataModel {
  int? id;
  String? title;
  String? flag;
  @JsonKey(name: 'user_id')
  int? userId;
  String? description;
  MediaModel? cover;
  UserModel? user;
  List<MediaModel>? media;

  DataModel(
      {this.id,
      this.title,
      this.flag,
      this.userId,
      this.cover,
      this.description,
      this.user,
      this.media});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return _$DataModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}

@JsonSerializable()
class MetaModel {
  @JsonKey(name: 'current_page')
  int? currentPage;
  @JsonKey(name: 'last_page')
  int? lastPage;
  @JsonKey(name: 'per_page')
  int? perPage;
  int? total;

  MetaModel({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return _$MetaModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MetaModelToJson(this);
}

@JsonSerializable()
class LevelModel {
  String? key;
  String? value;
  LevelModel({
    this.key,
    this.value,
  });

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return _$LevelModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LevelModelToJson(this);
}

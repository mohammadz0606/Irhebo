// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:irhebo/domain/models/config_model.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/domain/models/login_model.dart';

part 'service_details_model.g.dart';

@JsonSerializable()
class ServiceDetailsModel {
  ServiceModel? service;
  List<DataModel>? portoflio;
  List<ReviewModel>? reviews;
  List<ServiceModel>? recommended;
  List<PlanModel>? plans;
  ServiceDetailsModel({
    this.service,
    this.portoflio,
    this.reviews,
    this.recommended,
    this.plans,
  });

  factory ServiceDetailsModel.fromJson(Map<String, dynamic> json) {
    return _$ServiceDetailsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ServiceDetailsModelToJson(this);
}

@JsonSerializable()
class ReviewModel {
  int? id;
  int? rating;
  String? comment;
  @JsonKey(name: 'created_at')
  String? createdAt;
  UserModel? user;
  bool show;
  ReviewModel(
      {this.id,
      this.rating,
      this.comment,
      this.createdAt,
      this.user,
      this.show = false});

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return _$ReviewModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}

@JsonSerializable()
class PlanModel {
  int? id;
  String? title;
  String? price;
  @JsonKey(name: 'delivery_days')
  int? deliveryDays;
  List<FeatureModel>? features;
  PlanModel({
    this.id,
    this.title,
    this.price,
    this.deliveryDays,
    this.features,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return _$PlanModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PlanModelToJson(this);
}

@JsonSerializable()
class FeatureModel {
  int? id;
  String? title;
  String? value;
  FeatureModel({
    this.id,
    this.title,
    this.value,
  });

  factory FeatureModel.fromJson(Map<String, dynamic> json) {
    return _$FeatureModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FeatureModelToJson(this);
}

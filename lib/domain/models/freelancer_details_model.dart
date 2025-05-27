// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/domain/models/service_details_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irhebo/domain/models/config_model.dart';

part 'freelancer_details_model.g.dart';

@JsonSerializable()
class FreelancerDetailsModel {
  FreelancerModel? freelancer;
  @JsonKey(name: 'average_rating')
  String? averageRating;
  ProfileReviews? reviews;
  PaginationModel? portfolio;
  ProfileServices? services;
  FreelancerDetailsModel({
    this.freelancer,
    this.averageRating,
    this.reviews,
    this.portfolio,
    this.services,
  });

  factory FreelancerDetailsModel.fromJson(Map<String, dynamic> json) {
    return _$FreelancerDetailsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FreelancerDetailsModelToJson(this);
}

@JsonSerializable()
class FreelancerModel {
  int? id;
  String? name;
  String? email;
  @JsonKey(name: 'full_phone')
  String? fullPhone;
  String? prefix;
  String? phone;
  String? gender;
  String? profession;
  String? country;
  String? avatar;
  String? role;
  String? description;
  String? status;
  List<DataModel>? languages;
  FreelancerModel({
    this.id,
    this.name,
    this.email,
    this.fullPhone,
    this.prefix,
    this.phone,
    this.gender,
    this.profession,
    this.country,
    this.avatar,
    this.role,
    this.description,
    this.status,
    this.languages,
  });

  factory FreelancerModel.fromJson(Map<String, dynamic> json) {
    return _$FreelancerModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FreelancerModelToJson(this);
}

@JsonSerializable()
class PaginationModel {
  List<DataModel>? data;
  MetaModel? meta;
  PaginationModel({
    this.data,
    this.meta,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return _$PaginationModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);
}

@JsonSerializable()
class ProfileReviews {
  List<ReviewModel>? data;
  MetaModel? meta;
  ProfileReviews({
    this.data,
    this.meta,
  });

  factory ProfileReviews.fromJson(Map<String, dynamic> json) {
    return _$ProfileReviewsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfileReviewsToJson(this);
}

@JsonSerializable()
class ProfileServices {
  List<ServiceModel>? data;
  MetaModel? meta;
  ProfileServices({
    this.data,
    this.meta,
  });

  factory ProfileServices.fromJson(Map<String, dynamic> json) {
    return _$ProfileServicesFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfileServicesToJson(this);
}

@JsonSerializable()
class PaginatedPortfolio {
  List<DataModel>? portfolios;
  MetaModel? meta;
  PaginatedPortfolio({
    this.portfolios,
    this.meta,
  });

  factory PaginatedPortfolio.fromJson(Map<String, dynamic> json) {
    return _$PaginatedPortfolioFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaginatedPortfolioToJson(this);
}

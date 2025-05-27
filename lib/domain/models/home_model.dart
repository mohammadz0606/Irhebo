// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:irhebo/domain/models/config_model.dart';
import 'package:irhebo/domain/models/freelancer_details_model.dart';
import 'package:irhebo/domain/models/login_model.dart';

part 'home_model.g.dart';

@JsonSerializable()
class HomeModel {
  List<CategoryModel>? categories;
  @JsonKey(name: 'recommended_services')
  List<ServiceModel>? recommendedServices;
  @JsonKey(name: 'featured_portfolios')
  PaginationModel? featuredPortfolios;
  HomeModel({
    this.categories,
    this.recommendedServices,
    this.featuredPortfolios,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return _$HomeModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HomeModelToJson(this);
}

@JsonSerializable()
class CategoryModel {
  int? id;
  String? icon;
  @JsonKey(name: 'max_price')
  String? maxPrice;
  String? title;
  String? description;
  String? cover;
  bool checked;
  CategoryModel({
    this.id,
    this.icon,
    this.maxPrice,
    this.title,
    this.checked = false,
    this.description,
    this.cover,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return _$CategoryModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@JsonSerializable()
class SubcategoryModel {
  int? id;
  @JsonKey(name: 'category_id')
  int? categoryId;
  String? icon;
  String? title;
  SubcategoryModel({
    this.id,
    this.categoryId,
    this.icon,
    this.title,
  });

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    return _$SubcategoryModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SubcategoryModelToJson(this);
}

@JsonSerializable()
class TagModel {
  int? id;
  @JsonKey(name: 'sub_category_id')
  int? subCategoryId;
  String? title;
  String? slug;
  TagModel({
    this.id,
    this.subCategoryId,
    this.title,
    this.slug,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return _$TagModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TagModelToJson(this);
}

@JsonSerializable()
class AllServices {
  List<ServiceModel>? services;
  MetaModel? meta;
  List<TagModel>? tags;
  AllServices({
    this.services,
    this.meta,
    this.tags,
  });

  factory AllServices.fromJson(Map<String, dynamic> json) {
    return _$AllServicesFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AllServicesToJson(this);
}

@JsonSerializable()
class ServiceModel {
  int? id;
  @JsonKey(name: 'sub_category_id')
  int? subCategoryId;
  String? title;
  String? description;
  String? cover;
  @JsonKey(name: 'is_recommended')
  bool? isRecommended;
  @JsonKey(name: 'is_wishlist')
  bool? isWishlist;
  int? rating;
  @JsonKey(name: 'start_service_from')
  String? startServiceFrom;
  UserModel? user;
  List<MediaModel>? media;

  ServiceModel(
      {this.id,
      this.subCategoryId,
      this.title,
      this.description,
      this.cover,
      this.isRecommended,
      this.isWishlist,
      this.rating,
      this.startServiceFrom,
      this.user,
      this.media});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return _$ServiceModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);
}

@JsonSerializable()
class MediaModel {
  int? id;
  @JsonKey(name: 'media_path')
  String? mediaPath;
  @JsonKey(name: 'media_type')
  String? mediaType;
  @JsonKey(name: 'message_id')
  int? messageId;
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'created_at')
  String? createdAt;
  MediaModel({
    this.id,
    this.mediaPath,
    this.mediaType,
    this.messageId,
    this.userId,
    this.createdAt,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return _$MediaModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MediaModelToJson(this);
}

@JsonSerializable()
class FilterModel {
  int? id;
  String? title;
  String? type;
  int? min;
  int? max;
  bool checked;
  int? rateValue;
  List<FilterOptionModel>? options;
  // TextEditingController? minCon = TextEditingController();
  // TextEditingController? maxCon = TextEditingController();
  // RangeValues? slider;
  FilterModel({
    this.id,
    this.title,
    this.type,
    this.min,
    this.rateValue,
    this.max,
    this.checked = false,
    this.options,
    // this.maxCon,
    // this.minCon,
    // this.slider,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return _$FilterModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FilterModelToJson(this);
}

@JsonSerializable()
class FilterOptionModel {
  int? id;
  @JsonKey(name: 'filter_id')
  int? filterId;
  String? title;
  FilterOptionModel({
    this.id,
    this.filterId,
    this.title,
  });

  factory FilterOptionModel.fromJson(Map<String, dynamic> json) {
    return _$FilterOptionModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FilterOptionModelToJson(this);
}

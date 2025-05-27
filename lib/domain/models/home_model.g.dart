// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) => HomeModel(
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommendedServices: (json['recommended_services'] as List<dynamic>?)
          ?.map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      featuredPortfolios: json['featured_portfolios'] == null
          ? null
          : PaginationModel.fromJson(
              json['featured_portfolios'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeModelToJson(HomeModel instance) => <String, dynamic>{
      'categories': instance.categories,
      'recommended_services': instance.recommendedServices,
      'featured_portfolios': instance.featuredPortfolios,
    };

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: (json['id'] as num?)?.toInt(),
      icon: json['icon'] as String?,
      maxPrice: json['max_price'] as String?,
      title: json['title'] as String?,
      checked: json['checked'] as bool? ?? false,
      description: json['description'] as String?,
      cover: json['cover'] as String?,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'icon': instance.icon,
      'max_price': instance.maxPrice,
      'title': instance.title,
      'description': instance.description,
      'cover': instance.cover,
      'checked': instance.checked,
    };

SubcategoryModel _$SubcategoryModelFromJson(Map<String, dynamic> json) =>
    SubcategoryModel(
      id: (json['id'] as num?)?.toInt(),
      categoryId: (json['category_id'] as num?)?.toInt(),
      icon: json['icon'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$SubcategoryModelToJson(SubcategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category_id': instance.categoryId,
      'icon': instance.icon,
      'title': instance.title,
    };

TagModel _$TagModelFromJson(Map<String, dynamic> json) => TagModel(
      id: (json['id'] as num?)?.toInt(),
      subCategoryId: (json['sub_category_id'] as num?)?.toInt(),
      title: json['title'] as String?,
      slug: json['slug'] as String?,
    );

Map<String, dynamic> _$TagModelToJson(TagModel instance) => <String, dynamic>{
      'id': instance.id,
      'sub_category_id': instance.subCategoryId,
      'title': instance.title,
      'slug': instance.slug,
    };

AllServices _$AllServicesFromJson(Map<String, dynamic> json) => AllServices(
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => TagModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllServicesToJson(AllServices instance) =>
    <String, dynamic>{
      'services': instance.services,
      'meta': instance.meta,
      'tags': instance.tags,
    };

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) => ServiceModel(
      id: (json['id'] as num?)?.toInt(),
      subCategoryId: (json['sub_category_id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      cover: json['cover'] as String?,
      isRecommended: json['is_recommended'] as bool?,
      isWishlist: json['is_wishlist'] as bool?,
      rating: (json['rating'] as num?)?.toInt(),
      startServiceFrom: json['start_service_from'] as String?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      media: (json['media'] as List<dynamic>?)
          ?.map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sub_category_id': instance.subCategoryId,
      'title': instance.title,
      'description': instance.description,
      'cover': instance.cover,
      'is_recommended': instance.isRecommended,
      'is_wishlist': instance.isWishlist,
      'rating': instance.rating,
      'start_service_from': instance.startServiceFrom,
      'user': instance.user,
      'media': instance.media,
    };

MediaModel _$MediaModelFromJson(Map<String, dynamic> json) => MediaModel(
      id: (json['id'] as num?)?.toInt(),
      mediaPath: json['media_path'] as String?,
      mediaType: json['media_type'] as String?,
      messageId: (json['message_id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$MediaModelToJson(MediaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'media_path': instance.mediaPath,
      'media_type': instance.mediaType,
      'message_id': instance.messageId,
      'user_id': instance.userId,
      'created_at': instance.createdAt,
    };

FilterModel _$FilterModelFromJson(Map<String, dynamic> json) => FilterModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      type: json['type'] as String?,
      min: (json['min'] as num?)?.toInt(),
      rateValue: (json['rateValue'] as num?)?.toInt(),
      max: (json['max'] as num?)?.toInt(),
      checked: json['checked'] as bool? ?? false,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => FilterOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FilterModelToJson(FilterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'min': instance.min,
      'max': instance.max,
      'checked': instance.checked,
      'rateValue': instance.rateValue,
      'options': instance.options,
    };

FilterOptionModel _$FilterOptionModelFromJson(Map<String, dynamic> json) =>
    FilterOptionModel(
      id: (json['id'] as num?)?.toInt(),
      filterId: (json['filter_id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$FilterOptionModelToJson(FilterOptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'filter_id': instance.filterId,
      'title': instance.title,
    };

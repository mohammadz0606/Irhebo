// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freelancer_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreelancerDetailsModel _$FreelancerDetailsModelFromJson(
        Map<String, dynamic> json) =>
    FreelancerDetailsModel(
      freelancer: json['freelancer'] == null
          ? null
          : FreelancerModel.fromJson(
              json['freelancer'] as Map<String, dynamic>),
      averageRating: json['average_rating'] as String?,
      reviews: json['reviews'] == null
          ? null
          : ProfileReviews.fromJson(json['reviews'] as Map<String, dynamic>),
      portfolio: json['portfolio'] == null
          ? null
          : PaginationModel.fromJson(json['portfolio'] as Map<String, dynamic>),
      services: json['services'] == null
          ? null
          : ProfileServices.fromJson(json['services'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FreelancerDetailsModelToJson(
        FreelancerDetailsModel instance) =>
    <String, dynamic>{
      'freelancer': instance.freelancer,
      'average_rating': instance.averageRating,
      'reviews': instance.reviews,
      'portfolio': instance.portfolio,
      'services': instance.services,
    };

FreelancerModel _$FreelancerModelFromJson(Map<String, dynamic> json) =>
    FreelancerModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      fullPhone: json['full_phone'] as String?,
      prefix: json['prefix'] as String?,
      phone: json['phone'] as String?,
      gender: json['gender'] as String?,
      profession: json['profession'] as String?,
      country: json['country'] as String?,
      avatar: json['avatar'] as String?,
      role: json['role'] as String?,
      description: json['description'] as String?,
      status: json['status'] as String?,
      bio: json['bio'] as String?,
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => DataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FreelancerModelToJson(FreelancerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'full_phone': instance.fullPhone,
      'prefix': instance.prefix,
      'phone': instance.phone,
      'gender': instance.gender,
      'profession': instance.profession,
      'country': instance.country,
      'avatar': instance.avatar,
      'role': instance.role,
      'description': instance.description,
      'status': instance.status,
      'languages': instance.languages,
    };

PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) =>
    PaginationModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaginationModelToJson(PaginationModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };

ProfileReviews _$ProfileReviewsFromJson(Map<String, dynamic> json) =>
    ProfileReviews(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileReviewsToJson(ProfileReviews instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };

ProfileServices _$ProfileServicesFromJson(Map<String, dynamic> json) =>
    ProfileServices(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileServicesToJson(ProfileServices instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };

PaginatedPortfolio _$PaginatedPortfolioFromJson(Map<String, dynamic> json) =>
    PaginatedPortfolio(
      portfolios: (json['portfolios'] as List<dynamic>?)
          ?.map((e) => DataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaginatedPortfolioToJson(PaginatedPortfolio instance) =>
    <String, dynamic>{
      'portfolios': instance.portfolios,
      'meta': instance.meta,
    };

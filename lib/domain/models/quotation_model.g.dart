// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedQuotationsModel _$PaginatedQuotationsModelFromJson(
        Map<String, dynamic> json) =>
    PaginatedQuotationsModel(
      quotations: (json['quotations'] as List<dynamic>?)
          ?.map((e) => QuotationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaginatedQuotationsModelToJson(
        PaginatedQuotationsModel instance) =>
    <String, dynamic>{
      'quotations': instance.quotations,
      'meta': instance.meta,
    };

QuotationModel _$QuotationModelFromJson(Map<String, dynamic> json) =>
    QuotationModel(
        id: (json['id'] as num?)?.toInt(),
        title: json['title'] as String?,
        description: json['description'] as String?,
        price: json['price'] as String?,
        deliveryDay: (json['delivery_day'] as num?)?.toInt(),
        revisions: (json['revisions'] as num?)?.toInt(),
        sourceFile: json['source_file'] as bool?,
        user: json['user'] == null
            ? null
            : UserModel.fromJson(json['user'] as Map<String, dynamic>),
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        comments: (json['comments'] as List<dynamic>?)
            ?.map((e) =>
                QuotationCommentModel.fromJson(e as Map<String, dynamic>))
            .toList());

Map<String, dynamic> _$QuotationModelToJson(QuotationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'delivery_day': instance.deliveryDay,
      'revisions': instance.revisions,
      'source_file': instance.sourceFile,
      'user': instance.user,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

QuotationCommentModel _$QuotationCommentModelFromJson(
        Map<String, dynamic> json) =>
    QuotationCommentModel(
      id: (json['id'] as num?)?.toInt(),
      comment: json['comment'] as String?,
      quotationId: (json['quotation_id'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$QuotationCommentModelToJson(
        QuotationCommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'quotation_id': instance.quotationId,
      'user': instance.user,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

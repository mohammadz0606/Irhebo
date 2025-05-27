// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:irhebo/domain/models/config_model.dart';
import 'package:irhebo/domain/models/login_model.dart';

part 'quotation_model.g.dart';

@JsonSerializable()
class PaginatedQuotationsModel {
  List<QuotationModel>? quotations;
  MetaModel? meta;
  PaginatedQuotationsModel({
    this.quotations,
    this.meta,
  });

  factory PaginatedQuotationsModel.fromJson(Map<String, dynamic> json) {
    return _$PaginatedQuotationsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaginatedQuotationsModelToJson(this);
}

@JsonSerializable()
class QuotationModel {
  int? id;
  String? title;
  String? description;
  String? price;
  @JsonKey(name: 'delivery_day')
  int? deliveryDay;
  int? revisions;
  @JsonKey(name: 'source_file')
  bool? sourceFile;
  UserModel? user;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  QuotationModel({
    this.id,
    this.title,
    this.description,
    this.price,
    this.deliveryDay,
    this.revisions,
    this.sourceFile,
    this.user,
    this.createdAt,
    this.updatedAt,
  });

  factory QuotationModel.fromJson(Map<String, dynamic> json) {
    return _$QuotationModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$QuotationModelToJson(this);
}

@JsonSerializable()
class QuotationCommentModel {
  int? id;
  String? comment;
  @JsonKey(name: 'quotation_id')
  int? quotationId;
  UserModel? user;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  QuotationCommentModel({
    this.id,
    this.comment,
    this.quotationId,
    this.user,
    this.createdAt,
    this.updatedAt,
  });

  factory QuotationCommentModel.fromJson(Map<String, dynamic> json) {
    return _$QuotationCommentModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$QuotationCommentModelToJson(this);
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'checkout_model.g.dart';

@JsonSerializable()
class CheckoutModel {
  String? id;
  String? description;
  @JsonKey(name: 'sub_total')
  String? subTotal;
  String? tax;
  String? total;
  String? title;
  @JsonKey(name: 'plan_title')
  String? planTitle;
  CheckoutModel({
    this.id,
    this.description,
    this.subTotal,
    this.tax,
    this.total,
    this.title,
    this.planTitle,
  });

  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    return _$CheckoutModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CheckoutModelToJson(this);
}

@JsonSerializable()
class CheckoutServiceModel {
  @JsonKey(name: 'request_info')
  CheckoutModel? service;

  CheckoutServiceModel({
    this.service,
  });

  factory CheckoutServiceModel.fromJson(Map<String, dynamic> json) {
    return _$CheckoutServiceModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CheckoutServiceModelToJson(this);
}

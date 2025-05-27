// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'otp_model.g.dart';

@JsonSerializable()
class OtpModel {
  String? code;

  OtpModel({
    this.code,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) {
    return _$OtpModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OtpModelToJson(this);
}

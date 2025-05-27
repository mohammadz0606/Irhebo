// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'faq_model.g.dart';

@JsonSerializable()
class FaqModel {
  int? id;
  String? question;
  String? answer;
  @JsonKey(name: 'media_path')
  String? mediaPath;
  @JsonKey(name: 'media_type')
  String? mediaType;
  bool visible;
  FaqModel({
    this.id,
    this.question,
    this.answer,
    this.mediaPath,
    this.visible = false,
    this.mediaType,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return _$FaqModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FaqModelToJson(this);
}

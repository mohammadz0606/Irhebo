// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'slider_model.g.dart';

@JsonSerializable()
class SliderModel {
  int? id;
  String? title;
  String? description;
  @JsonKey(name: 'button_action')
  String? buttonAction;
  @JsonKey(name: 'button_text')
  String? buttonText;
  @JsonKey(name: 'media_path')
  String? mediaPath;
  @JsonKey(name: 'media_type')
  String? mediaType;

  SliderModel({
    this.id,
    this.title,
    this.description,
    this.buttonAction,
    this.buttonText,
    this.mediaPath,
    this.mediaType,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return _$SliderModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SliderModelToJson(this);
}

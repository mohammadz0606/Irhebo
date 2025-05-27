// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'general_model.g.dart';

@JsonSerializable()
class GeneralModel {
  String? email;
  String? phone;
  String? whatsapp;
  String? facebook;
  String? twitter;
  String? instagram;
  String? linkedin;
  String? youtube;
  String? address;
  @JsonKey(name: 'working_hours')
  String? workingHours;
  String? privacy;
  String? terms;
  String? about;
  @JsonKey(name: 'site_title')
  String? siteTitle;
  @JsonKey(name: 'site_description')
  String? siteDescription;
  String? currency;
  @JsonKey(name: 'currency_symbol')
  String? currencySymbol;
  String? timezone;
  @JsonKey(name: 'unread_notifications')
  int? unreadNotifications;
  @JsonKey(name: 'unread_messages')
  int? unreadMessages;
  @JsonKey(name: 'platform_title')
  String? platformTitle;
  @JsonKey(name: 'platform_description')
  String? platformDescription;
  @JsonKey(name: 'platform_logo')
  String? platformLogo;
  GeneralModel({
    this.email,
    this.phone,
    this.whatsapp,
    this.facebook,
    this.twitter,
    this.instagram,
    this.linkedin,
    this.youtube,
    this.address,
    this.workingHours,
    this.privacy,
    this.terms,
    this.about,
    this.siteTitle,
    this.siteDescription,
    this.currency,
    this.currencySymbol,
    this.timezone,
    this.unreadNotifications,
    this.unreadMessages,
    this.platformTitle,
    this.platformDescription,
    this.platformLogo,
  });

  factory GeneralModel.fromJson(Map<String, dynamic> json) {
    return _$GeneralModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GeneralModelToJson(this);
}

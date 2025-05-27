// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralModel _$GeneralModelFromJson(Map<String, dynamic> json) => GeneralModel(
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      whatsapp: json['whatsapp'] as String?,
      facebook: json['facebook'] as String?,
      twitter: json['twitter'] as String?,
      instagram: json['instagram'] as String?,
      linkedin: json['linkedin'] as String?,
      youtube: json['youtube'] as String?,
      address: json['address'] as String?,
      workingHours: json['working_hours'] as String?,
      privacy: json['privacy'] as String?,
      terms: json['terms'] as String?,
      about: json['about'] as String?,
      siteTitle: json['site_title'] as String?,
      siteDescription: json['site_description'] as String?,
      currency: json['currency'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      timezone: json['timezone'] as String?,
      unreadNotifications: (json['unread_notifications'] as num?)?.toInt(),
      unreadMessages: (json['unread_messages'] as num?)?.toInt(),
      platformTitle: json['platform_title'] as String?,
      platformDescription: json['platform_description'] as String?,
      platformLogo: json['platform_logo'] as String?,
    );

Map<String, dynamic> _$GeneralModelToJson(GeneralModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
      'whatsapp': instance.whatsapp,
      'facebook': instance.facebook,
      'twitter': instance.twitter,
      'instagram': instance.instagram,
      'linkedin': instance.linkedin,
      'youtube': instance.youtube,
      'address': instance.address,
      'working_hours': instance.workingHours,
      'privacy': instance.privacy,
      'terms': instance.terms,
      'about': instance.about,
      'site_title': instance.siteTitle,
      'site_description': instance.siteDescription,
      'currency': instance.currency,
      'currency_symbol': instance.currencySymbol,
      'timezone': instance.timezone,
      'unread_notifications': instance.unreadNotifications,
      'unread_messages': instance.unreadMessages,
      'platform_title': instance.platformTitle,
      'platform_description': instance.platformDescription,
      'platform_logo': instance.platformLogo,
    };

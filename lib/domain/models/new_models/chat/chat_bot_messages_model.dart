
import 'dart:developer';

import 'package:intl/intl.dart';

class BotMessagesModel {
  bool? success;
  String? message;
  List<BotMessagesModelMessages>? messages;

  BotMessagesModel({
    this.success,
    this.message,
    this.messages,
  });
  BotMessagesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message']?.toString();
    if (json['messages'] != null) {
      final v = json['messages'];
      final arr0 = <BotMessagesModelMessages>[];
      v.forEach((v) {
        arr0.add(BotMessagesModelMessages.fromJson(v));
      });
      messages = arr0;
    }
  }
}

class BotMessagesModelMessages {


  int? id;
  String? message;
  String? role;
  List<BotMessagesModelMessagesServices>? services;
  DateTime? createdAt;

  BotMessagesModelMessages({
    this.id,
    this.message,
    this.role,
    this.services,
    this.createdAt,
  });
  BotMessagesModelMessages.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    message = json['message']?.toString();
    role = json['role']?.toString();
    if (json['services'] != null) {
      final v = json['services'];
      final arr0 = <BotMessagesModelMessagesServices>[];
      v.forEach((v) {
        arr0.add(BotMessagesModelMessagesServices.fromJson(v));
      });
      services = arr0;
    }
    final dateString = json['created_at']?.toString();
    if (dateString != null) {
      try {
        createdAt = DateFormat('EEE, MMM d, yyyy h:mm a', 'en_US').parse(dateString);
      } catch (e) {
        log('Date parsing error: $e | value = $dateString');
        createdAt = DateTime.now();
      }
    }
  }
}

class BotMessagesModelMessagesServices {

  int? id;
  int? subCategoryId;
  String? title;
  String? description;
  String? cover;
  bool? isRecommended;
  bool? isWishlist;
  int? rating;
  String? startServiceFrom;
  BotMessagesModelMessagesServicesUser? user;

  BotMessagesModelMessagesServices({
    this.id,
    this.subCategoryId,
    this.title,
    this.description,
    this.cover,
    this.isRecommended,
    this.isWishlist,
    this.rating,
    this.startServiceFrom,
    this.user,
  });
  BotMessagesModelMessagesServices.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    subCategoryId = json['sub_category_id']?.toInt();
    title = json['title']?.toString();
    description = json['description']?.toString();
    cover = json['cover']?.toString();
    isRecommended = json['is_recommended'];
    isWishlist = json['is_wishlist'];
    rating = json['rating']?.toInt();
    startServiceFrom = json['start_service_from']?.toString();
    user = (json['user'] != null) ? BotMessagesModelMessagesServicesUser.fromJson(json['user']) : null;
  }

}

class BotMessagesModelMessagesServicesUser {

  int? id;
  String? username;
  String? profession;
  String? avatar;

  BotMessagesModelMessagesServicesUser({
    this.id,
    this.username,
    this.profession,
    this.avatar,
  });
  BotMessagesModelMessagesServicesUser.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    username = json['username']?.toString();
    profession = json['profession']?.toString();
    avatar = json['avatar']?.toString();
  }
}







class NewSearchModel {

  bool? status;
  String? message;
  NewSearchModelData? data;

  NewSearchModel({
    this.status,
    this.message,
    this.data,
  });
  NewSearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = (json['data'] != null) ? NewSearchModelData.fromJson(json['data']) : null;
  }

}

class NewSearchModelData {

  List<NewSearchModelDataServices?>? services;
  List<NewSearchModelDataSubCategories?>? subCategories;

  NewSearchModelData({
    this.services,
    this.subCategories,
  });
  NewSearchModelData.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      final v = json['services'];
      final arr0 = <NewSearchModelDataServices>[];
      v.forEach((v) {
        arr0.add(NewSearchModelDataServices.fromJson(v));
      });
      services = arr0;
    }
    if (json['sub_categories'] != null) {
      final v = json['sub_categories'];
      final arr0 = <NewSearchModelDataSubCategories>[];
      v.forEach((v) {
        arr0.add(NewSearchModelDataSubCategories.fromJson(v));
      });
      subCategories = arr0;
    }
  }

}

class NewSearchModelDataSubCategories {
  int? id;
  int? categoryId;
  String? icon;
  String? title;

  NewSearchModelDataSubCategories({
    this.id,
    this.categoryId,
    this.icon,
    this.title,
  });
  NewSearchModelDataSubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    categoryId = json['category_id']?.toInt();
    icon = json['icon']?.toString();
    title = json['title']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['icon'] = icon;
    data['title'] = title;
    return data;
  }
}

class NewSearchModelDataServicesUser {

  int? id;
  String? username;
  String? profession;
  String? avatar;

  NewSearchModelDataServicesUser({
    this.id,
    this.username,
    this.profession,
    this.avatar,
  });
  NewSearchModelDataServicesUser.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    username = json['username']?.toString();
    profession = json['profession']?.toString();
    avatar = json['avatar']?.toString();
  }

}

class NewSearchModelDataServices {


  int? id;
  int? subCategoryId;
  String? title;
  String? description;
  String? cover;
  bool? isRecommended;
  bool? isWishlist;
  int? rating;
  String? startServiceFrom;
  NewSearchModelDataServicesUser? user;

  NewSearchModelDataServices({
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
  NewSearchModelDataServices.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    subCategoryId = json['sub_category_id']?.toInt();
    title = json['title']?.toString();
    description = json['description']?.toString();
    cover = json['cover']?.toString();
    isRecommended = json['is_recommended'];
    isWishlist = json['is_wishlist'];
    rating = json['rating']?.toInt();
    startServiceFrom = json['start_service_from']?.toString();
    user = (json['user'] != null) ? NewSearchModelDataServicesUser.fromJson(json['user']) : null;
  }
}




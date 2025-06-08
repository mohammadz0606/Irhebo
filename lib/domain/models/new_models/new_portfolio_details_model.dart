class NewPortfolioDetailsModel {
  bool? status;
  String? message;
  NewPortfolioDetailsModelData? data;

  NewPortfolioDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  NewPortfolioDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = (json['data'] != null)
        ? NewPortfolioDetailsModelData.fromJson(json['data'])
        : null;
  }
}

class NewPortfolioDetailsModelData {
  int? id;
  int? userId;
  String? title;
  String? description;
  List<NewPortfolioDetailsModelDataMedia?>? media;
  List<NewPortfolioDetailsModelDataService?>? service;

  NewPortfolioDetailsModelData({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.media,
    this.service,
  });

  NewPortfolioDetailsModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    userId = json['user_id']?.toInt();
    title = json['title']?.toString();
    description = json['description']?.toString();
    if (json['media'] != null) {
      final v = json['media'];
      final arr0 = <NewPortfolioDetailsModelDataMedia>[];
      v.forEach((v) {
        arr0.add(NewPortfolioDetailsModelDataMedia.fromJson(v));
      });
      media = arr0;
    }
    if (json['service'] != null) {
      final v = json['service'];
      final arr0 = <NewPortfolioDetailsModelDataService>[];
      v.forEach((v) {
        arr0.add(NewPortfolioDetailsModelDataService.fromJson(v));
      });
      service = arr0;
    }
  }
}




class NewPortfolioDetailsModelDataServiceUser {


  int? id;
  String? username;
  String? profession;
  String? avatar;

  NewPortfolioDetailsModelDataServiceUser({
    this.id,
    this.username,
    this.profession,
    this.avatar,
  });

  NewPortfolioDetailsModelDataServiceUser.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    username = json['username']?.toString();
    profession = json['profession']?.toString();
    avatar = json['avatar']?.toString();
  }
}

class NewPortfolioDetailsModelDataService {


  int? id;
  int? subCategoryId;
  String? title;
  String? description;
  String? cover;
  bool? isRecommended;
  bool? isWishlist;
  int? rating;
  NewPortfolioDetailsModelDataServiceUser? user;

  NewPortfolioDetailsModelDataService({
    this.id,
    this.subCategoryId,
    this.title,
    this.description,
    this.cover,
    this.isRecommended,
    this.isWishlist,
    this.rating,
    this.user,
  });

  NewPortfolioDetailsModelDataService.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    subCategoryId = json['sub_category_id']?.toInt();
    title = json['title']?.toString();
    description = json['description']?.toString();
    cover = json['cover']?.toString();
    isRecommended = json['is_recommended'];
    isWishlist = json['is_wishlist'];
    rating = json['rating']?.toInt();
    user = (json['user'] != null)
        ? NewPortfolioDetailsModelDataServiceUser.fromJson(json['user'])
        : null;
  }
}

class NewPortfolioDetailsModelDataMedia {

  int? id;
  String? mediaPath;
  String? mediaType;
  bool? isCover;

  NewPortfolioDetailsModelDataMedia({
    this.id,
    this.mediaPath,
    this.mediaType,
    this.isCover,
  });

  NewPortfolioDetailsModelDataMedia.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    mediaPath = json['media_path']?.toString();
    mediaType = json['media_type']?.toString();
    isCover = json['is_cover'];
  }
}



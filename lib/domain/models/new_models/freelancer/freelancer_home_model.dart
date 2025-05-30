final class FreelancerHomeModel {
  bool? status;
  String? message;
  FreelancerHomeModelData? data;

  FreelancerHomeModel({
    this.status,
    this.message,
    this.data,
  });

  FreelancerHomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = (json['data'] != null)
        ? FreelancerHomeModelData.fromJson(json['data'])
        : null;
  }
}

class FreelancerHomeModelDataQuotationsUser {
  int? id;
  String? username;
  String? avatar;
  String? profession;

  FreelancerHomeModelDataQuotationsUser({
    this.id,
    this.username,
    this.avatar,
    this.profession,
  });

  FreelancerHomeModelDataQuotationsUser.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    username = json['username']?.toString();
    avatar = json['avatar']?.toString();
    profession = json['profession']?.toString();
  }
}

class FreelancerHomeModelDataQuotations {
  int? id;
  String? title;
  String? description;
  String? price;
  int? deliveryDay;
  int? revisions;
  bool? sourceFile;
  FreelancerHomeModelDataQuotationsUser? user;
  String? createdAt;
  String? updatedAt;
  bool? disabledComment;

  FreelancerHomeModelDataQuotations({
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
    this.disabledComment,
  });

  FreelancerHomeModelDataQuotations.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
    description = json['description']?.toString();
    price = json['price']?.toString();
    deliveryDay = json['delivery_day']?.toInt();
    revisions = json['revisions']?.toInt();
    sourceFile = json['source_file'];
    user = (json['user'] != null)
        ? FreelancerHomeModelDataQuotationsUser.fromJson(json['user'])
        : null;
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    disabledComment = json['disabled_comment'];
  }
}

class FreelancerHomeModelDataPortfoliosUser {
/*
{
  "id": 1,
  "username": "Freelancer A",
  "profession": "Software Developer",
  "avatar": "https://irhebo-backend.smartedge.me/storage/avatars/1746131048_avatar.png"
}
*/

  int? id;
  String? username;
  String? profession;
  String? avatar;

  FreelancerHomeModelDataPortfoliosUser({
    this.id,
    this.username,
    this.profession,
    this.avatar,
  });

  FreelancerHomeModelDataPortfoliosUser.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    username = json['username']?.toString();
    profession = json['profession']?.toString();
    avatar = json['avatar']?.toString();
  }
}

class FreelancerHomeModelDataPortfoliosCover {
/*
{
  "id": 72,
  "media_path": "https://irhebo-backend.smartedge.me/storage/portfolios/1746865858_1000020853.jpg",
  "media_type": "image"
}
*/

  int? id;
  String? mediaPath;
  String? mediaType;

  FreelancerHomeModelDataPortfoliosCover({
    this.id,
    this.mediaPath,
    this.mediaType,
  });

  FreelancerHomeModelDataPortfoliosCover.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    mediaPath = json['media_path']?.toString();
    mediaType = json['media_type']?.toString();
  }
}

class FreelancerHomeModelDataPortfolios {
/*
{
  "id": 27,
  "title": "hjiin",
  "user_id": 1,
  "cover": {
    "id": 72,
    "media_path": "https://irhebo-backend.smartedge.me/storage/portfolios/1746865858_1000020853.jpg",
    "media_type": "image"
  },
  "user": {
    "id": 1,
    "username": "Freelancer A",
    "profession": "Software Developer",
    "avatar": "https://irhebo-backend.smartedge.me/storage/avatars/1746131048_avatar.png"
  }
}
*/

  int? id;
  String? title;
  int? userId;
  FreelancerHomeModelDataPortfoliosCover? cover;
  FreelancerHomeModelDataPortfoliosUser? user;

  FreelancerHomeModelDataPortfolios({
    this.id,
    this.title,
    this.userId,
    this.cover,
    this.user,
  });

  FreelancerHomeModelDataPortfolios.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
    userId = json['user_id']?.toInt();
    cover = (json['cover'] != null)
        ? FreelancerHomeModelDataPortfoliosCover.fromJson(json['cover'])
        : null;
    user = (json['user'] != null)
        ? FreelancerHomeModelDataPortfoliosUser.fromJson(json['user'])
        : null;
  }
}

class FreelancerHomeModelDataServicesUser {
  int? id;
  String? username;
  String? profession;
  String? avatar;

  FreelancerHomeModelDataServicesUser({
    this.id,
    this.username,
    this.profession,
    this.avatar,
  });

  FreelancerHomeModelDataServicesUser.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    username = json['username']?.toString();
    profession = json['profession']?.toString();
    avatar = json['avatar']?.toString();
  }
}

class FreelancerHomeModelDataServices {
  int? id;
  int? subCategoryId;
  String? title;
  String? description;
  String? cover;
  bool? isRecommended;
  bool? isWishlist;
  int? rating;
  String? startServiceFrom;
  FreelancerHomeModelDataServicesUser? user;

  FreelancerHomeModelDataServices({
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

  FreelancerHomeModelDataServices.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    subCategoryId = json['sub_category_id']?.toInt();
    title = json['title']?.toString();
    description = json['description']?.toString();
    cover = json['cover']?.toString();
    isRecommended = json['is_recommended'];
    isWishlist = json['is_wishlist'];
    rating = json['rating']?.toInt();
    startServiceFrom = json['start_service_from']?.toString();
    user = (json['user'] != null)
        ? FreelancerHomeModelDataServicesUser.fromJson(json['user'])
        : null;
  }
}

class FreelancerHomeModelData {
  List<FreelancerHomeModelDataServices?>? services;
  List<FreelancerHomeModelDataPortfolios?>? portfolios;
  List<FreelancerHomeModelDataQuotations?>? quotations;

  FreelancerHomeModelData({
    this.services,
    this.portfolios,
    this.quotations,
  });

  FreelancerHomeModelData.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      final v = json['services'];
      final arr0 = <FreelancerHomeModelDataServices>[];
      v.forEach((v) {
        arr0.add(FreelancerHomeModelDataServices.fromJson(v));
      });
      services = arr0;
    }
    if (json['portfolios'] != null) {
      final v = json['portfolios'];
      final arr0 = <FreelancerHomeModelDataPortfolios>[];
      v.forEach((v) {
        arr0.add(FreelancerHomeModelDataPortfolios.fromJson(v));
      });
      portfolios = arr0;
    }
    if (json['quotations'] != null) {
      final v = json['quotations'];
      final arr0 = <FreelancerHomeModelDataQuotations>[];
      v.forEach((v) {
        arr0.add(FreelancerHomeModelDataQuotations.fromJson(v));
      });
      quotations = arr0;
    }
  }
}

class FreelancerServiceModel {
  bool? status;
  String? message;
  FreelancerServiceModelData? data;

  FreelancerServiceModel({
    this.status,
    this.message,
    this.data,
  });

  FreelancerServiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = (json['data'] != null)
        ? FreelancerServiceModelData.fromJson(json['data'])
        : null;
  }
}

class FreelancerServiceModelDataMeta {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;

  FreelancerServiceModelDataMeta({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
  });

  FreelancerServiceModelDataMeta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page']?.toInt();
    lastPage = json['last_page']?.toInt();
    perPage = json['per_page']?.toInt();
    total = json['total']?.toInt();
  }
}

class FreelancerServiceModelDataServicesUser {
  int? id;
  String? username;
  String? profession;
  String? avatar;

  FreelancerServiceModelDataServicesUser({
    this.id,
    this.username,
    this.profession,
    this.avatar,
  });

  FreelancerServiceModelDataServicesUser.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    username = json['username']?.toString();
    profession = json['profession']?.toString();
    avatar = json['avatar']?.toString();
  }
}

class FreelancerServiceModelDataServices {
  int? id;
  int? subCategoryId;
  String? title;
  String? description;
  String? cover;
  bool? isRecommended;
  bool? isWishlist;
  int? rating;
  String? startServiceFrom;
  FreelancerServiceModelDataServicesUser? user;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FreelancerServiceModelDataServices &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

  FreelancerServiceModelDataServices({
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

  FreelancerServiceModelDataServices.fromJson(Map<String, dynamic> json) {
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
        ? FreelancerServiceModelDataServicesUser.fromJson(json['user'])
        : null;
  }
}

class FreelancerServiceModelData {
  List<FreelancerServiceModelDataServices?>? services;
  FreelancerServiceModelDataMeta? meta;

  FreelancerServiceModelData({
    this.services,
    this.meta,
  });

  FreelancerServiceModelData.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      final v = json['services'];
      final arr0 = <FreelancerServiceModelDataServices>[];
      v.forEach((v) {
        arr0.add(FreelancerServiceModelDataServices.fromJson(v));
      });
      services = arr0;
    }
    meta = (json['meta'] != null)
        ? FreelancerServiceModelDataMeta.fromJson(json['meta'])
        : null;
  }
}

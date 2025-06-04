class PortfolioListModel {
  bool? status;
  String? message;
  PortfolioListModelData? data;

  PortfolioListModel({
    this.status,
    this.message,
    this.data,
  });

  PortfolioListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = (json['data'] != null)
        ? PortfolioListModelData.fromJson(json['data'])
        : null;
  }
}

class PortfolioListModelData {
  List<PortfolioListModelDataPortfolios>? portfolios;
  PortfolioListModelDataMeta? meta;

  PortfolioListModelData({
    this.portfolios,
    this.meta,
  });

  PortfolioListModelData.fromJson(Map<String, dynamic> json) {
    if (json['portfolios'] != null) {
      final v = json['portfolios'];
      final arr0 = <PortfolioListModelDataPortfolios>[];
      v.forEach((v) {
        arr0.add(PortfolioListModelDataPortfolios.fromJson(v));
      });
      portfolios = arr0;
    }
    meta = (json['meta'] != null)
        ? PortfolioListModelDataMeta.fromJson(json['meta'])
        : null;
  }
}

class PortfolioListModelDataPortfolios {
  int? id;
  String? title;
  int? userId;
  PortfolioListModelDataPortfoliosCover? cover;
  PortfolioListModelDataPortfoliosUser? user;

  PortfolioListModelDataPortfolios({
    this.id,
    this.title,
    this.userId,
    this.cover,
    this.user,
  });

  PortfolioListModelDataPortfolios.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
    userId = json['user_id']?.toInt();
    cover = (json['cover'] != null)
        ? PortfolioListModelDataPortfoliosCover.fromJson(json['cover'])
        : null;
    user = (json['user'] != null)
        ? PortfolioListModelDataPortfoliosUser.fromJson(json['user'])
        : null;
  }
}

class PortfolioListModelDataMeta {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;

  PortfolioListModelDataMeta({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
  });

  PortfolioListModelDataMeta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page']?.toInt();
    lastPage = json['last_page']?.toInt();
    perPage = json['per_page']?.toInt();
    total = json['total']?.toInt();
  }
}

class PortfolioListModelDataPortfoliosUser {
  int? id;
  String? username;
  String? profession;
  String? avatar;

  PortfolioListModelDataPortfoliosUser({
    this.id,
    this.username,
    this.profession,
    this.avatar,
  });

  PortfolioListModelDataPortfoliosUser.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    username = json['username']?.toString();
    profession = json['profession']?.toString();
    avatar = json['avatar']?.toString();
  }
}

class PortfolioListModelDataPortfoliosCover {
  int? id;
  String? mediaPath;
  String? mediaType;

  PortfolioListModelDataPortfoliosCover({
    this.id,
    this.mediaPath,
    this.mediaType,
  });

  PortfolioListModelDataPortfoliosCover.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    mediaPath = json['media_path']?.toString();
    mediaType = json['media_type']?.toString();
  }
}

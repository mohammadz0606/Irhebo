class TagsModel {
  bool? status;
  String? message;
  List<TagsModelData?>? data;

  TagsModel({
    this.status,
    this.message,
    this.data,
  });

  TagsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <TagsModelData>[];
      v.forEach((v) {
        arr0.add(TagsModelData.fromJson(v));
      });
      data = arr0;
    }
  }
}

class TagsModelData {
  int? id;
  int? subCategoryId;
  String? slug;
  String? createdAt;
  String? updatedAt;
  // List<TagsModelDataTranslation?>? translation;
  // TagsModelDataSubCategory? subCategory;

  TagsModelData({
    this.id,
    this.subCategoryId,
    this.slug,
    this.createdAt,
    this.updatedAt,
    // this.translation,
    // this.subCategory,
  });

  TagsModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    subCategoryId = json['sub_category_id']?.toInt();
    slug = json['slug']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    // if (json['translation'] != null) {
    //   final v = json['translation'];
    //   final arr0 = <TagsModelDataTranslation>[];
    //   v.forEach((v) {
    //     arr0.add(TagsModelDataTranslation.fromJson(v));
    //   });
    //   translation = arr0;
    // }
    // subCategory = (json['sub_category'] != null)
    //     ? TagsModelDataSubCategory.fromJson(json['sub_category'])
    //     : null;
  }
}


class TagsModelDataSubCategoryTranslation {
  int? id;
  String? language;
  String? title;
  String? createdAt;
  String? updatedAt;

  TagsModelDataSubCategoryTranslation({
    this.id,
    this.language,
    this.title,
    this.createdAt,
    this.updatedAt,
  });

  TagsModelDataSubCategoryTranslation.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    language = json['language']?.toString();
    title = json['title']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }
}

class TagsModelDataSubCategory {


  int? id;
  int? categoryId;
  String? icon;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  TagsModelDataSubCategoryTranslation? translation;

  TagsModelDataSubCategory({
    this.id,
    this.categoryId,
    this.icon,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.translation,
  });

  TagsModelDataSubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    categoryId = json['category_id']?.toInt();
    icon = json['icon']?.toString();
    isActive = json['is_active']?.toInt();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    translation = (json['translation'] != null)
        ? TagsModelDataSubCategoryTranslation.fromJson(json['translation'])
        : null;
  }
}

class TagsModelDataTranslation {
  int? id;
  String? language;
  String? title;
  String? createdAt;
  String? updatedAt;

  TagsModelDataTranslation({
    this.id,
    this.language,
    this.title,
    this.createdAt,
    this.updatedAt,
  });

  TagsModelDataTranslation.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    language = json['language']?.toString();
    title = json['title']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }
}





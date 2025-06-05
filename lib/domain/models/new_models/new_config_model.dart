class NewConfigModel {
  bool? status;
  String? message;
  NewConfigModelData? data;

  NewConfigModel({
    this.status,
    this.message,
    this.data,
  });

  NewConfigModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = (json['data'] != null)
        ? NewConfigModelData.fromJson(json['data'])
        : null;
  }

}

class NewConfigModelDataLanguagesLevels {
/*
{
  "key": "beginner",
  "value": "مبتدئ"
}
*/

  String? key;
  String? value;

  NewConfigModelDataLanguagesLevels({
    this.key,
    this.value,
  });

  NewConfigModelDataLanguagesLevels.fromJson(Map<String, dynamic> json) {
    key = json['key']?.toString();
    value = json['value']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}

class NewConfigModelDataLanguagesData {
/*
{
  "id": 43,
  "title": "Afrikaans",
  "flag": "https://flagcdn.com/w320/za.png"
}
*/

  int? id;
  String? title;
  String? flag;

  NewConfigModelDataLanguagesData({
    this.id,
    this.title,
    this.flag,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NewConfigModelDataLanguagesData && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  NewConfigModelDataLanguagesData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
    flag = json['flag']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['flag'] = flag;
    return data;
  }
}

class NewConfigModelDataLanguages {

  List<NewConfigModelDataLanguagesData?>? data;
  List<NewConfigModelDataLanguagesLevels>? levels;

  NewConfigModelDataLanguages({
    this.data,
    this.levels,
  });

  NewConfigModelDataLanguages.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <NewConfigModelDataLanguagesData>[];
      v.forEach((v) {
        arr0.add(NewConfigModelDataLanguagesData.fromJson(v));
      });
      this.data = arr0;
    }
    if (json['levels'] != null) {
      final v = json['levels'];
      final arr0 = <NewConfigModelDataLanguagesLevels>[];
      v.forEach((v) {
        arr0.add(NewConfigModelDataLanguagesLevels.fromJson(v));
      });
      levels = arr0;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['data'] = arr0;
    }
    if (levels != null) {
      final v = levels;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['levels'] = arr0;
    }
    return data;
  }
}

class NewConfigModelDataCountries {
  int? id;
  String? title;
  String? flag;

  NewConfigModelDataCountries({
    this.id,
    this.title,
    this.flag,
  });

  NewConfigModelDataCountries.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
    flag = json['flag']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['flag'] = flag;
    return data;
  }
}

class NewConfigModelDataProfessions {
/*
{
  "id": 1,
  "title": "مطور برمجيات"
}
*/

  int? id;
  String? title;

  NewConfigModelDataProfessions({
    this.id,
    this.title,
  });

  NewConfigModelDataProfessions.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}

class NewConfigModelData {

  List<NewConfigModelDataProfessions?>? professions;
  List<NewConfigModelDataCountries?>? countries;
  NewConfigModelDataLanguages? languages;

  NewConfigModelData({
    this.professions,
    this.countries,
    this.languages,
  });

  NewConfigModelData.fromJson(Map<String, dynamic> json) {
    if (json['professions'] != null) {
      final v = json['professions'];
      final arr0 = <NewConfigModelDataProfessions>[];
      v.forEach((v) {
        arr0.add(NewConfigModelDataProfessions.fromJson(v));
      });
      professions = arr0;
    }
    if (json['countries'] != null) {
      final v = json['countries'];
      final arr0 = <NewConfigModelDataCountries>[];
      v.forEach((v) {
        arr0.add(NewConfigModelDataCountries.fromJson(v));
      });
      countries = arr0;
    }
    languages = (json['languages'] != null)
        ? NewConfigModelDataLanguages.fromJson(json['languages'])
        : null;
  }


}

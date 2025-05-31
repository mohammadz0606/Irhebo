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

class FreelancerServiceModelDataLanguages {
  int? id;
  String? title;
  String? flag;
  String? level;

  FreelancerServiceModelDataLanguages({
    this.id,
    this.title,
    this.flag,
    this.level,
  });

  FreelancerServiceModelDataLanguages.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
    flag = json['flag']?.toString();
    level = json['level']?.toString();
  }
}

class FreelancerServiceModelDataCountryObject {
  int? id;
  String? title;

  FreelancerServiceModelDataCountryObject({
    this.id,
    this.title,
  });

  FreelancerServiceModelDataCountryObject.fromJson(Map<String, dynamic> json) {
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

class FreelancerServiceModelDataProfessionObject {
  int? id;
  String? title;

  FreelancerServiceModelDataProfessionObject({
    this.id,
    this.title,
  });

  FreelancerServiceModelDataProfessionObject.fromJson(
      Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
  }
}

class FreelancerServiceModelData {
  int? id;
  String? name;
  String? email;
  String? fullPhone;
  String? prefix;
  String? phone;
  String? gender;
  String? profession;
  FreelancerServiceModelDataProfessionObject? professionObject;
  String? country;
  FreelancerServiceModelDataCountryObject? countryObject;
  String? avatar;
  String? role;
  List<FreelancerServiceModelDataLanguages?>? languages;

  FreelancerServiceModelData({
    this.id,
    this.name,
    this.email,
    this.fullPhone,
    this.prefix,
    this.phone,
    this.gender,
    this.profession,
    this.professionObject,
    this.country,
    this.countryObject,
    this.avatar,
    this.role,
    this.languages,
  });

  FreelancerServiceModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    email = json['email']?.toString();
    fullPhone = json['full_phone']?.toString();
    prefix = json['prefix']?.toString();
    phone = json['phone']?.toString();
    gender = json['gender']?.toString();
    profession = json['profession']?.toString();
    professionObject = (json['profession_object'] != null)
        ? FreelancerServiceModelDataProfessionObject.fromJson(
            json['profession_object'])
        : null;
    country = json['country']?.toString();
    countryObject = (json['country_object'] != null)
        ? FreelancerServiceModelDataCountryObject.fromJson(
            json['country_object'])
        : null;
    avatar = json['avatar']?.toString();
    role = json['role']?.toString();
    if (json['languages'] != null) {
      final v = json['languages'];
      final arr0 = <FreelancerServiceModelDataLanguages>[];
      v.forEach((v) {
        arr0.add(FreelancerServiceModelDataLanguages.fromJson(v));
      });
      languages = arr0;
    }
  }
}

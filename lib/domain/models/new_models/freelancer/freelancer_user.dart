import '../../login_model.dart';

class UserFreelancerModel {
  bool? status;
  String? message;
  UserFreelancerModelData? data;

  UserFreelancerModel({
    this.status,
    this.message,
    this.data,
  });

  UserFreelancerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = (json['data'] != null)
        ? UserFreelancerModelData.fromJson(json['data'])
        : null;
  }
}

class UserFreelancerModelData {
  UserFreelancerModelDataFreelancer? freelancer;

  UserFreelancerModelData({
    this.freelancer,
  });

  UserFreelancerModelData.fromJson(Map<String, dynamic> json) {
    freelancer = (json['freelancer'] != null)
        ? UserFreelancerModelDataFreelancer.fromJson(json['freelancer'])
        : null;
  }
}

class UserFreelancerModelDataFreelancerCertificates {
  int? id;
  String? fileName;
  String? filePath;
  String? description;

  UserFreelancerModelDataFreelancerCertificates({
    this.id,
    this.fileName,
    this.filePath,
    this.description,
  });

  UserFreelancerModelDataFreelancerCertificates.fromJson(
      Map<String, dynamic> json) {
    id = json['id']?.toInt();
    fileName = json['file_name']?.toString();
    filePath = json['file_path']?.toString();
    description = json['description']?.toString();
  }
}

class UserFreelancerModelDataFreelancer {
  int? id;
  String? name;
  String? email;
  String? fullPhone;
  String? prefix;
  String? phone;
  String? gender;
  String? country;
  String? profession;
  String? avatar;
  String? role;
  String? bio;
  String? status;
  List<UserFreelancerModelDataFreelancerCertificates>? certificates;
  List<LanguageModel>? languages;

  UserFreelancerModelDataFreelancer({
    this.id,
    this.name,
    this.email,
    this.fullPhone,
    this.prefix,
    this.phone,
    this.gender,
    this.country,
    this.avatar,
    this.role,
    this.bio,
    this.status,
    this.certificates,
    this.languages,
    this.profession,
  });

  UserFreelancerModelDataFreelancer.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    email = json['email']?.toString();
    fullPhone = json['full_phone']?.toString();
    prefix = json['prefix']?.toString();
    phone = json['phone']?.toString();
    gender = json['gender']?.toString();
    country = json['country']?.toString();
    avatar = json['avatar']?.toString();
    role = json['role']?.toString();
    bio = json['bio']?.toString();
    profession = json['profession']?.toString();
    status = json['status']?.toString();
    if (json['certificates'] != null) {
      final v = json['certificates'];
      final arr0 = <UserFreelancerModelDataFreelancerCertificates>[];
      v.forEach((v) {
        arr0.add(UserFreelancerModelDataFreelancerCertificates.fromJson(v));
      });
      certificates = arr0;
    }

    if (json['languages'] != null) {
      final v = json['languages'];
      final arr0 = <LanguageModel>[];
      v.forEach((v) {
        arr0.add(LanguageModel.fromJson(v));
      });
      languages = arr0;
    }
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart' as dio;

class UpdateProfileParams {
  String? username;
  dio.MultipartFile? avatar;
  String? gender;
  String? description;
  int? professionId;
  int? countryId;
  List<int>? languages;
  UpdateProfileParams({
    this.username,
    this.avatar,
    this.gender,
    this.description,
    this.professionId,
    this.countryId,
    this.languages,
  });

  Map<String, dynamic> toJson() {
    return {
      if (gender != null) 'gender': gender,
      if (username != null) 'username': username,
      if (description != null) 'description': description,
      if (professionId != null) 'profession_id': professionId,
      if (countryId != null) 'country_id': countryId,
      if (languages != null) 'languages': languages,
      if (avatar != null) 'avatar': [avatar],
    };
  }
}

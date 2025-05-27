class RegisterParams {
  final String? username;
  final String? email;
  final String? password;
  final String? confirmPassword;
  final String? prefix;
  final String? phone;
  final String? gender;
  final int? professionId;
  final int? countryId;
  final List<int>? languages;

  RegisterParams({
    this.username,
    this.email,
    this.password,
    this.confirmPassword,
    this.prefix,
    this.phone,
    this.gender,
    this.professionId,
    this.countryId,
    this.languages,
  });

  RegisterParams copyWith({
    String? username,
    String? email,
    String? password,
    String? confirmPassword,
    String? prefix,
    String? phone,
    String? gender,
    int? professionId,
    int? countryId,
    List<int>? languages,
  }) =>
      RegisterParams(
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        prefix: prefix ?? this.prefix,
        phone: phone ?? this.phone,
        gender: gender ?? this.gender,
        professionId: professionId ?? this.professionId,
        countryId: countryId ?? this.countryId,
        languages: languages ?? this.languages,
      );

  factory RegisterParams.fromJson(Map<String, dynamic> json) => RegisterParams(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        confirmPassword: json["confirm_password"],
        prefix: json["prefix"],
        phone: json["phone"],
        gender: json["gender"],
        professionId: json["profession_id"],
        countryId: json["country_id"],
        languages: json["languages"] == null
            ? []
            : List<int>.from(json["languages"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "confirm_password": confirmPassword,
        "prefix": prefix,
        "phone": phone,
        "gender": gender,
        "profession_id": professionId,
        "country_id": countryId,
        "languages": languages == null
            ? []
            : List<dynamic>.from(languages!.map((x) => x)),
      };
}

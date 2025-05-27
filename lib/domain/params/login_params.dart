class LoginParams {
  final String? prefix;
  final String? phone;
  final String? password;

  LoginParams({
    this.prefix,
    this.phone,
    this.password,
  });

  LoginParams copyWith({
    String? prefix,
    String? phone,
    String? password,
  }) =>
      LoginParams(
        prefix: prefix ?? this.prefix,
        phone: phone ?? this.phone,
        password: password ?? this.password,
      );

  factory LoginParams.fromJson(Map<String, dynamic> json) => LoginParams(
        prefix: json["prefix"],
        phone: json["phone"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "prefix": prefix,
        "phone": phone,
        "password": password,
      };
}

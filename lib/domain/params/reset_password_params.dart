class ResetPasswordParams {
  final String? prefix;
  final String? phone;
  final String? password;
  final String? confirmPassword;

  ResetPasswordParams({
    this.prefix,
    this.phone,
    this.password,
    this.confirmPassword,
  });

  ResetPasswordParams copyWith({
    String? prefix,
    String? phone,
    String? password,
    String? confirmPassword,
  }) =>
      ResetPasswordParams(
        prefix: prefix ?? this.prefix,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
      );

  factory ResetPasswordParams.fromJson(Map<String, dynamic> json) =>
      ResetPasswordParams(
        prefix: json["prefix"],
        phone: json["phone"],
        password: json["password"],
        confirmPassword: json["confirm_password"],
      );

  Map<String, dynamic> toJson() => {
        "prefix": prefix,
        "phone": phone,
        "password": password,
        "confirm_password": confirmPassword,
      };
}

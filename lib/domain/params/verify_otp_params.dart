class VerifyOtpParams {
  final String? prefix;
  final String? phone;
  final String? code;

  VerifyOtpParams({
    this.prefix,
    this.phone,
    this.code,
  });

  VerifyOtpParams copyWith({
    String? prefix,
    String? phone,
    String? code,
  }) =>
      VerifyOtpParams(
        prefix: prefix ?? this.prefix,
        phone: phone ?? this.phone,
        code: code ?? this.code,
      );

  factory VerifyOtpParams.fromJson(Map<String, dynamic> json) =>
      VerifyOtpParams(
        prefix: json["prefix"],
        phone: json["phone"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "prefix": prefix,
        "phone": phone,
        "code": code,
      };
}

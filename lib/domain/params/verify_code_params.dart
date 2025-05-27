class VerifyCodeParams {
  final String? prefix;
  final String? phone;
  final String? code;

  VerifyCodeParams({
    this.prefix,
    this.phone,
    this.code
  });

  VerifyCodeParams copyWith({
    String? prefix,
    String? phone,
    String? code
  }) =>
      VerifyCodeParams(
        prefix: prefix ?? this.prefix,
        phone: phone ?? this.phone,
        code: code ?? this.code
      );

  factory VerifyCodeParams.fromJson(Map<String, dynamic> json) => VerifyCodeParams(
    prefix: json["prefix"],
    phone: json["phone"],
    code: json["code"]
  );

  Map<String, dynamic> toJson() => {
    "prefix": prefix,
    "phone": phone,
    "code":code
  };
}

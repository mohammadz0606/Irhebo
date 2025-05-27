class SendOtpParams {
  final String? prefix;
  final String? phone;

  SendOtpParams({
    this.prefix,
    this.phone,
  });

  SendOtpParams copyWith({
    String? prefix,
    String? phone,
  }) =>
      SendOtpParams(
        prefix: prefix ?? this.prefix,
        phone: phone ?? this.phone,
      );

  factory SendOtpParams.fromJson(Map<String, dynamic> json) => SendOtpParams(
        prefix: json["prefix"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "prefix": prefix,
        "phone": phone,
      };
}

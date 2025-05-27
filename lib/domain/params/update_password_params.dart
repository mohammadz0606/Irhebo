class UpdatePasswordParams {
  String? oldPassword;
  String? newPassword;
  String? confirmationPassword;

  UpdatePasswordParams({
    this.oldPassword,
    this.newPassword,
    this.confirmationPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      if (oldPassword != null) 'old_password': oldPassword,
      if (newPassword != null) 'new_password': newPassword,
      if (confirmationPassword != null)
        'new_password_confirmation': confirmationPassword,
    };
  }
}

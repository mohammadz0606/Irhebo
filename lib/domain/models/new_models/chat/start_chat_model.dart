final class StartChatModel {
  int? chatId;
  int? userId;

  StartChatModel({
    this.chatId,
    this.userId,
  });

  factory StartChatModel.fromJson(Map<String, dynamic> json) {
    return StartChatModel(
      chatId: json['data']["id"],
      userId: json['data']["user_id_two"],
    );
  }
}

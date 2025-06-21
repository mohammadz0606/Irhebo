
class ToggleParam {

  String? flag;
  String? chatId;

  ToggleParam({
    this.flag,
    this.chatId,
  });
  ToggleParam.fromJson(Map<String, dynamic> json) {
    flag = json['flag']?.toString();
    chatId = json['chat_id']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['flag'] = flag;
    data['chat_id'] = chatId;
    return data;
  }
}

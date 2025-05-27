// ignore_for_file: public_member_api_docs, sort_constructors_first

class ChatEntity {
  String? id;
  String? senderId;
  String? receiverId;
  String? message;
  String? messageType;
  bool? sender;
  String? name;
  String? image;
  String? type;
  String? timestamp; // Required for sorting

  ChatEntity(
      {this.id,
      this.senderId,
      this.receiverId,
      this.message,
      this.messageType,
      this.sender,
      this.name,
      this.image,
      this.timestamp,
      this.type});
}

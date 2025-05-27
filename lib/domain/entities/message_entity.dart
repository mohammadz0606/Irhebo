// ignore_for_file: public_member_api_docs, sort_constructors_first

class ChatMessageEntity {
  String id;
  String senderId;
  String receiverId;
  String message;
  String messageType;
  bool sender;
  DateTime timestamp; // Required for sorting

  ChatMessageEntity({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.messageType,
    required this.sender,
    required this.timestamp,
  });

  ChatMessageEntity copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    String? message,
    String? messageType,
    bool? sender,
    DateTime? timestamp,
  }) {
    return ChatMessageEntity(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      message: message ?? this.message,
      messageType: messageType ?? this.messageType,
      sender: sender ?? this.sender,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

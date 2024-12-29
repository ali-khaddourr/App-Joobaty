class MessageModel {
  String senderId;
  String receiverId;
  String message;
  DateTime timestamp;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  // تحويل الرسالة إلى JSON لإرسالها إلى API
  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // إنشاء نموذج رسالة من JSON
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

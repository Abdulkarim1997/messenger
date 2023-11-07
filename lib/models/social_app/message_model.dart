class MessageModel {
  String? senderId;
  String? reciverId;
  String? dateTime;
  String? text;

  MessageModel({
    required this.senderId,
    required this.reciverId,
    required this.dateTime,
    required this.text,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        senderId: json["senderId"],
        reciverId: json["reciverId"],
        dateTime: json["dateTime"],
        text: json["text"],
      );

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'reciverId': reciverId,
      'dateTime': dateTime,
      'text': text,
    };
  }
}

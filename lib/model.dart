class Message {
  String message;
  String sentByMe;

  Message({required this.message, required this.sentByMe});
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(message: json["message"], sentByMe: json["sentBy"]);
  }
}

class AllMessages {
  String message;
  String sentBy;

  AllMessages({required this.message, required this.sentBy});
  factory AllMessages.fromJson(Map<String, dynamic> json) {
    return AllMessages(message: json["message"], sentBy: json["sentBy"]);
  }
}

class Welcome {
  String message;
  Welcome({required this.message});
}

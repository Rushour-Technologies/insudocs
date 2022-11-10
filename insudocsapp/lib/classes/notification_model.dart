import 'dart:convert';

class NotificationModel {
  String body = "";
  String title = "";
  NotificationModel({
    required this.body,
    required this.title,
  });

  NotificationModel copyWith({
    String? body,
    String? title,
  }) {
    return NotificationModel(
      body: body ?? this.body,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'body': body,
      'title': title,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      body: map['body'] ?? '',
      title: map['title'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));
}

class NotificationModel {
  const NotificationModel({
    required this.title,
    required this.body,
    required this.sendTo,
    this.isTopic = false,
  });

  final String title;
  final String body;
  final String sendTo;
  final bool isTopic;

  String get to => isTopic ? '/topics/$sendTo' : sendTo;

  Map<String, dynamic> toJson() => {
        'to': to,
        'title': title,
        'notification': {
          'body': body,
          'title': title,
        },
        'data': {
          'body': body,
          'title': title,
        }
      };
}

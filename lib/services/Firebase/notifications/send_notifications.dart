import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:insudox/globals.dart';
import 'package:insudox/src/classes/notification_model.dart';

Future<void> sendNotification({required NotificationModel notification}) async {
  // Works for android devices only
  http.Response request = await http.post(
    Uri.parse('https://fcm.googleapis.com/fcm/send'),
    headers: {
      'Authorization': 'key=$SERVER_KEY',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(notification.toJson()),
  );
  if (request.statusCode == 200) {
    print('Success');
  } else {
    print('Failure');

    throw Exception('Failed to send notification');
  }
}

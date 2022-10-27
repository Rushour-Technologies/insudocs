import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:insudox_app/services/Firebase/firestore/firestore.dart';

/// Service for the push notifications
class PushNotificationService {
  /// The base setup message for checking running service
  Future<void> setupInteractedMessage() async {
    // This function is called when the app is in the background and user clicks on the notification

    FirebaseMessaging.instance.setAutoInitEnabled(true);
    FirebaseMessaging.onBackgroundMessage((message) async {});

    await registerNotificationListeners();
  }

  /// Register the notification listeners
  registerNotificationListeners() async {
    /// Channel for the android notifications
    AndroidNotificationChannel channel = androidNotificationChannel();

    /// Initialize the flutter local notifications
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    // Creating the notification channel
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Initialization settings for the android notifications
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    /// Initialization settings for the notifications
    const InitializationSettings initSetttings =
        InitializationSettings(android: androidSettings);

    // Initializing the notifications
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onDidReceiveNotificationResponse: (message) async {});

    // onMessage is called when the app is in foreground and a notification is received
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      print("GOD");
      RemoteNotification? notification = message!.notification;
      AndroidNotification? android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.

      print(message);
      await userDocumentCollection(collection: "messages").add({
        "title": notification!.title,
        "body": notification.body,
        "data": message.data,
      });

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android.smallIcon,
              playSound: true,
              importance: Importance.max,
              priority: Priority.max,
              visibility: NotificationVisibility.public,
              channelShowBadge: true,
            ),
          ),
        );
      }
    });
  }

  /// Android notification channel
  androidNotificationChannel() => AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.high,
        enableLights: true,
        vibrationPattern: Int64List(4),
      );
}

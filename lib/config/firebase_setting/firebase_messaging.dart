import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import 'access_firebase_token.dart';

Future<void> handleBg(RemoteMessage message) async {
  print("onBackgroundMessage:$message");
}

class FirebaseCM {
  final firebaseMessaging = FirebaseMessaging.instance;
  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    "Notification",
    "Notification",
    importance: Importance.max,
    playSound: true,
    showBadge: true,
    description: 'notificationChannelDesc',
  );
  final localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      print('Permission denied');
    }

    if (FirebaseAuth.instance.currentUser != null) {
      //final fcmToken = await firebaseMessaging.getToken();
      //update token here
    }
    await initPushNotification();
    await initLocalNotification();
    FirebaseMessaging.onMessage.listen((event) async {
      handleMessage(event);
      final notification = event.notification;
      final data = event.data;
      if (data.isNotEmpty) {
        print(data);
      }
      if (notification == null) return;
      localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  channelDescription: channel.description,
                  playSound: true,
                  importance: Importance.max,
                  priority: Priority.max,
                  icon: "@drawable/ic_launcher")));
    });
    FirebaseMessaging.onBackgroundMessage(handleBg);
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  Future initLocalNotification() async {
    const android = AndroidInitializationSettings("@drawable/ic_launcher");
    const settings = InitializationSettings(android: android);

    await localNotifications.initialize(settings);
    print('object');
  }

  void handleMessage(RemoteMessage? message) {
    if (message != null) {
      print("handleMessage:$message");
    }
  }

  static Future<void> subscribeToTopic() async {
    await FirebaseMessaging.instance.subscribeToTopic("notification");
  }

  Future<void> sendTokenNotification(
      String token, String title, String message) async {
    try {
      final body = {
        'message': {
          'token': token,
          'notification': {
            'body': message,
            'title': title,
          }
        }
      };
      // AccessTokenFirebase tokenFetcher = AccessTokenFirebase();
      String uri =
          "https://fcm.googleapis.com/v1/projects/mychat-5b639/messages:send";
      String accessToken = await AccessTokenFirebase().getAccessToke();
      await http
          .post(Uri.parse(uri),
              headers: {
                "Content-Type": 'application/json',
                'Authorization': 'Bearer $accessToken'
              },
              body: jsonEncode(body))
          .then(
        (value) {
          print("statuscode ${value.statusCode}");
        },
      );
    } catch (e) {
      print("sendTokenNotification Error:$e");
    }
  }

  Future<void> sendTopicNotification(
      String token, String title, String message) async {
    try {
      final body = {
        'message': {
          'topic': 'notification',
          'notification': {
            'body': message,
            'title': title,
          }
        }
      };
      // AccessTokenFirebase tokenFetcher = AccessTokenFirebase();
      String uri =
          "https://fcm.googleapis.com/v1/projects/mychat-5b639/messages:send";
      String accessToken = await AccessTokenFirebase().getAccessToke();
      await http
          .post(Uri.parse(uri),
              headers: {
                "Content-Type": 'application/json',
                'Authorization': 'Bearer $accessToken'
              },
              body: jsonEncode(body))
          .then(
        (value) {
          print("statuscode ${value.statusCode}");
        },
      );
    } catch (e) {
      print("sendTokenNotification Error:$e");
    }
  }

// Future<void> requestNotificationPermission() async {
//   // Check if we already have permission
//   var status = await Permission.notification.status;
//
//   // If permission is not granted, request it
//   if (!status.isGranted) {
//     await Permission.notification.request();
//   }
//
//   if (await Permission.notification.isGranted) {
//     print('Notification permission granted');
//   } else {
//     print('Notification permission denied');
//   }
// }
}

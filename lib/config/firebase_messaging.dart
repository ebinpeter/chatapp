import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart'as http;

import 'access_firebase_token.dart';

Future<void> handlebg(RemoteMessage message) async {
  print("onBackgroundMessage:$message");
}

class FirebaseCM {
  final firebaseMessaging = FirebaseMessaging.instance;
  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
      "Notfiaction", "Notification",
      importance: Importance.max, playSound: true, showBadge: true);

  final localNotification = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    // Request notification permissions
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Handle permission status
    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      print("Notification permission denied.");
    } else if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("Notification permission granted.");

      // Check if user is authenticated
      if (FirebaseAuth.instance.currentUser != null) {
        // Get the FCM token
        final fcmToken = await firebaseMessaging.getToken();
        print("FCM Token: $fcmToken");

        // Update the FCM token for the authenticated user
        if (fcmToken != null) {
          // You can now update the token in your database or with Firebase Auth
          // Example: updateTokenInDatabase(fcmToken);
        }
      }
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print("Provisional notification permission granted.");
    } else {
      print("User declined or has not accepted permission.");
    }

    // Register for background notifications
    FirebaseMessaging.onBackgroundMessage(handlebg);

    // Initialize push and local notifications
    initpushNotification();
    initLocalNotification();
  }

  Future<void> initpushNotification() async {
    ///    @mipmap/ic_launcher: This refers to the app's launcher icon located in the mipmap folder.
    ///    If you want to use a custom notification icon,
    ///    you can add it to the drawable folder and reference it like @drawable/custom_icon.
    ///    You should also ensure that the image is a valid resource in your res/drawable or res/mipmap folder.
    ///
    const android = AndroidInitializationSettings("@mipmap/ic_launcher");
    const InitializationSettings settings = InitializationSettings(android: android,);
    await localNotification.initialize(settings);
  }

  Future<void> initLocalNotification() async {
   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
     alert: true,
     badge:  true,
     sound:  true,
   );
   FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
   FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
  void handleMessage(RemoteMessage? message){
    if(message!=null){
      print("handleMessage:$message");
    }
  }
  void subcribetotopic(){
    FirebaseMessaging.instance.subscribeToTopic("notification");
  }

  Future<void>sendTokenNotification(String  token ,String title,String message)async{
    try{
      final body={
        'message':{
          'token':token,
          'notification':{
            'body':message,
            'title':title,
          }
        }
      };
      // AccessTokenFirebase tokenFetcher = AccessTokenFirebase();
      String uri =" https://fcm.googleapis.com/v1/projects/mychat-5b639/messages:send";
      String Acces_tokenKey = await AccessTokenFirebase().getAccessToke();
      await http.post(Uri.parse(uri),
      headers: {
        "Content-Type":'application/json',
        'Authorization':'Bearer $Acces_tokenKey'
      },
        body: jsonEncode(body)
      ).then((value) {
        print("statuscode ${value.statusCode}");
      },);
    }catch(e){
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

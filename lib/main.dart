
import 'package:chattick/config/firebase_setting/firebase.dart';
import 'package:chattick/config/firebase_setting/firebase_messaging.dart';
import 'package:chattick/feature/presentation/screen/contact.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'feature/presentation/screen/stat_msg_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseCM().initNotification();
  await FirebaseCM.subscribeToTopic();
  var checkislogin = await FirebaseApi().isLogincheck();
  // await FirebaseCM().requestNotificationPermission();
  runApp(MyApp(
    isLogin: checkislogin,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLogin;
  const MyApp({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isLogin
            ? const ContactsList() //homepage
            : const StartMsgPage());
  }
}

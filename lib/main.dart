import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'feature/presentation/screen/phone_numberpage.dart';
import 'feature/presentation/screen/stat_msg_page.dart';
import 'firebase_options.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: StatMsgPage(),
    );
  }
}
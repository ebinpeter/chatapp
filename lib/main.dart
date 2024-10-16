import 'package:chattick/config/firebase_setting/firebase.dart';
import 'package:chattick/config/firebase_setting/firebase_messaging.dart';
import 'package:chattick/feature/presentation/bloc/auth/auth_bloc.dart';
import 'package:chattick/feature/presentation/bloc/chat/chat_bloc.dart';
import 'package:chattick/feature/presentation/bloc/contact/contacts_bloc.dart';
import 'package:chattick/feature/presentation/screen/contact.dart';
import 'package:chattick/feature/presentation/widget/bottom_navi.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final firebaseApi = FirebaseApi();
            final authBloc = AuthBloc(firebaseApi);
            authBloc.add(CheckLoginAndNavigate());
            return authBloc;
          },
        ),
        BlocProvider<ContactsBloc>(
          create: (context) => ContactsBloc(),
        ),
        BlocProvider<ChatBloc>(
          create: (context) => ChatBloc()..add(LoadedChat()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoggedIn) {
            return const  BasePage();
          } else {
            return const StartMsgPage();
          }
        },
      ),
    );
  }
}

import 'package:chattick/config/firebase_setting/firebase.dart';
import 'package:chattick/config/firebase_setting/firebase_messaging.dart';
import 'package:chattick/feature/data/datasource/contact_datasource.dart';
import 'package:chattick/feature/data/repositories/contact_repo_imp.dart';
import 'package:chattick/feature/domain/repositories/contact_repositoy.dart';
import 'package:chattick/feature/domain/usecase/get_contacts.dart';
import 'package:chattick/feature/presentation/bloc/auth/auth_bloc.dart';
import 'package:chattick/feature/presentation/bloc/contact/contacts_bloc.dart';
import 'package:chattick/feature/presentation/screen/contact.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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

  // await FirebaseCM().requestNotificationPermission();
  final contactDataSource = ContactDataSource();
  final contactRepository = ContactRepoImply(contactDataSource); // Correct repository implementation
  final getContacts = GetContacts(contactRepository); // Pass the repository to the use case

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
          create: (context) => ContactsBloc(getContacts), // Correct use case passed to the bloc
        ),
      ],
      child: const MyApp(),
    ),
  );
      // BlocProvider(
      //   create: (context) {
      //     final firebaseApi = FirebaseApi();
      //     final authBloc = AuthBloc(firebaseApi);
      //     authBloc.add(CheckLoginAndNavigate());
      //     return authBloc;
      //   },
      //   child: const MyApp(),
      // ),
      // );
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
            return const ContactsList();
          } else {
            return const StartMsgPage();
          }
        },
      ),
    );
  }
}

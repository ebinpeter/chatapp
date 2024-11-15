import 'package:bloc/bloc.dart';
import 'package:chattick/config/firebase_setting/firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseApi firebaseApi;
  AuthBloc(this.firebaseApi) : super(AuthInitial()) {

    // on<CheckLoginEvent>((event, emit) async {
    //   try {
    //     final isLoggedIn = await firebaseApi.isLogincheck();
    //     if (isLoggedIn) {
    //       emit(AuthLoggedIn());
    //     } else {
    //       emit(AuthLoggedOut());
    //     }
    //   } catch (e) {
    //     emit(AuthLoggedOut());
    //   }
    // });

    on<CheckLoginAndNavigate>((event, emit) async {
      try {
        final isLoggedIn = await firebaseApi.isLogincheck();
        firebaseApi.fetchCurrentUser();
        if (isLoggedIn) {
          emit(AuthLoggedIn());
        } else {
          emit(AuthLoggedOut());
        }
      } catch (e) {
        emit(AuthLoggedOut());
      }
    });
  }
}

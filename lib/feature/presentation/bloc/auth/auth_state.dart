part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

 class AuthInitial extends AuthState {}

class AuthLoggedIn extends AuthState{
}
class AuthLoggedOut extends AuthState{}
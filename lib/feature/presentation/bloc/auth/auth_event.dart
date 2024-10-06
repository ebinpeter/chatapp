part of 'auth_bloc.dart';

abstract class AuthEvent {}

 class CheckLoginEvent extends AuthEvent{}
class CheckLoginAndNavigate extends AuthEvent {}



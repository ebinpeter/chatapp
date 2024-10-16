part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class LoadedChat extends ChatEvent {}
class LoadCurrentUser extends ChatEvent {}

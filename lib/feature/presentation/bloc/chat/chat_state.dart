part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();
}

final class UserInitial extends ChatState {
  @override
  List<Object> get props => [];
}


final class UserLoading extends ChatState {
  @override
  List<Object> get props => [];
}


final class UserLoaded extends ChatState {
  final List<QueryDocumentSnapshot> chats;

  const UserLoaded(this.chats);

  @override
  List<Object> get props => [chats];
}

final class UserError extends ChatState {
  final String message;

  const UserError(this.message);

  @override
  List<Object> get props => [message];
}

class CurrentUserLoaded extends ChatState {
  final Map<String, dynamic> currentUser;

  const CurrentUserLoaded(this.currentUser);

  @override
  List<Object?> get props => [currentUser];
}


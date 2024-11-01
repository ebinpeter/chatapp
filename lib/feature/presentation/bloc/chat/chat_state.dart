part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();
}

final class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}


final class ChatLoading extends ChatState {
  @override
  List<Object> get props => [];
}


final class ChatLoaded extends ChatState {
  final List<QueryDocumentSnapshot> chats;

  const ChatLoaded(this.chats);

  @override
  List<Object> get props => [chats];
}

final class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);

  @override
  List<Object> get props => [message];
}

class CurrentUserLoaded extends ChatState {
  final Map<String, dynamic> currentUser;

  const CurrentUserLoaded(this.currentUser);

  @override
  List<Object?> get props => [currentUser];
}


part of 'contacts_bloc.dart';

@immutable
sealed class ContactsState {}

final class ContactsInitial extends ContactsState {}

abstract class ContactState  {
  List<Object> get props => [];
}

class ContactInitial extends ContactsState{}

class ContactLoading extends ContactsState{}
class ContactEmpty extends ContactsState{}
class ContactLoaded extends ContactsState{
  final List<Contact> contacts;
  final List<Map<String, dynamic>> users;
  ContactLoaded(this.contacts, this.users);
}

class ContactError extends ContactsState{

   late final String message;
   List<Object> get props => [message];
   ContactError(this.message);

}

class ContactsAndUsersLoaded extends ContactsState{
  final List<Contact> contacts;
  final List<Map<String, dynamic>> users;
  ContactsAndUsersLoaded(this.contacts, this.users);

  @override
  List<Object> get props => [contacts, users];
}


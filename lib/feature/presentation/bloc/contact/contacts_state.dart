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
  ContactLoaded(this.contacts);
}

class ContactError extends ContactsState{

   late final String message;
   List<Object> get props => [message];
   ContactError(this.message);

}


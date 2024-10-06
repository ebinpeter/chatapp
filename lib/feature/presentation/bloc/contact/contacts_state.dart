part of 'contacts_bloc.dart';

@immutable
sealed class ContactsState {}

final class ContactsInitial extends ContactsState {}

abstract class ContactState {}

class ContactInitial extends ContactsState{}

class ContactLoading extends ContactsState{}
class ContactEmpty extends ContactsState{}

class ContactLoaded extends ContactsState{

  final List<ContactEntity> contats;
  ContactLoaded(this.contats);

}
class ContactError extends ContactsState{
   final String message;
   ContactError(this.message);
}


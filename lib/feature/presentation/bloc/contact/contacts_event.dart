part of 'contacts_bloc.dart';

@immutable
sealed class ContactsEvent {}

class fetchContactevent extends ContactsEvent{}

class SearchContactsEvent extends ContactsEvent {
  final String query;

  SearchContactsEvent(this.query);
}
part of 'contacts_bloc.dart';

@immutable
sealed class ContactsEvent {
  List<Object> get props => [];

}

class fetchContactevent extends ContactsEvent{}

class SearchContactsEvent extends ContactsEvent {
  final String query;

  SearchContactsEvent(this.query);
}

import 'package:bloc/bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:meta/meta.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc() : super(ContactLoading()) {
    on<fetchContactevent>(_onFetchContacts);
  }

  Future<void> _onFetchContacts(fetchContactevent event, Emitter<ContactsState> emit) async {
    try {
      if (await FlutterContacts.requestPermission()) {
        final List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);
        emit(ContactLoaded(contacts));
      } else {
        emit(ContactError('Permission denied to access contacts.'));
      }
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }
}
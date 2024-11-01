import 'package:bloc/bloc.dart';
import 'package:chattick/core/firebase_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      emit(ContactLoading());

      if (await FlutterContacts.requestPermission()) {
        final List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);

        final QuerySnapshot snapshot = await firestore.collection("user").get();
        final users = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

        emit(ContactLoaded(contacts,users));
      } else {
        emit(ContactError('Permission denied to access contacts.'));
      }
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }
}
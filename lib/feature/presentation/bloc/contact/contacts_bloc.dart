import 'package:bloc/bloc.dart';
import 'package:chattick/core/firebase_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      // final QuerySnapshot snapshot = await firestore.collection("users").get();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final uid = user.uid;
        final QuerySnapshot snapshot = await firestore.collection("users").get();

        final users = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .where((user) => user['uid'] != uid)
            .toList();

        final USers = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
        emit(ContactLoaded(users));

      } else {
        throw Exception("No user is currently logged in.");
      }
      // final users = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

      // Emit loaded state with Firebase users
    } catch (e) {
      emit(ContactError('Failed to fetch users: ${e.toString()}'));
    }
  }
}


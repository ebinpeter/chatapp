import 'package:bloc/bloc.dart';
import 'package:chattick/feature/domain/entities/contact.dart';
import 'package:chattick/feature/domain/usecase/get_contacts.dart';
import 'package:meta/meta.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final GetContacts getContacts;
  ContactsBloc(this.getContacts) : super(ContactsInitial()) {
    on<fetchContactevent>(_onFetchContacts);

  }
  Future<void> _onFetchContacts(fetchContactevent event, Emitter<ContactsState> emit,) async {
    emit(ContactLoading());

    try {
      final contacts = await getContacts();
      if (contacts.isEmpty) {
        emit(ContactEmpty());
      } else {
        emit(ContactLoaded(contacts));
      }
      // emit(ContactLoaded(contacts));
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }
}

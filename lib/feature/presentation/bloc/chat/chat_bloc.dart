import 'package:bloc/bloc.dart';
import 'package:chattick/config/firebase_setting/firebase.dart';
import 'package:chattick/core/firebase_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  List<DocumentSnapshot> currentUserList = [];

  ChatBloc() : super(UserLoading()) {
    on<LoadedChat>((event, emit) async {
      emit(UserLoading());
      try {
        await emit.forEach(
          FirebaseFirestore.instance.collection('users').snapshots(),
          onData: (snapshot) => UserLoaded(snapshot.docs),
          onError: (error, stackTrace) => UserError(error.toString()),
        );
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
    on<LoadCurrentUser>((event, emit) async {
      try {
        final String currentUserId = firebaseAuth.currentUser!.uid;
        final userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .get();


        if (userSnapshot.exists) {
          emit(CurrentUserLoaded(userSnapshot.data()!));
        } else {
          emit(UserError('No user found with the current UID.'));
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }

}
  


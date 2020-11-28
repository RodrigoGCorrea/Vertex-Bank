import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vertexbank/api/contact.dart';
import 'package:vertexbank/models/contact.dart';
import 'package:vertexbank/models/failure.dart';

part 'contact_list_watcher_state.dart';

class ContactListWatcherCubit extends Cubit<ContactListWatcherState> {
  ContactListWatcherCubit({
    @required this.contactApi,
  }) : super(ContactListWatcherInitial());

  final ContactApi contactApi;
  StreamSubscription<List<Contact>> _contactSubscription;

  void setContactListWatcher(String id) async {
    emit(ContactListWatcherLoading());
    try {
      await _contactSubscription?.cancel();
      _contactSubscription =
          contactApi.watchContactList(id).listen((contactList) {
        emit(ContactListWatcherLoading());
        emit(ContactListWatcherFinished(contactList: contactList));
      });
    } on Error catch (e) {
      //This should never reach!!!
      emit(ContactListWatcherError(error: Failure("$e")));
    }
  }

  @override
  Future<void> close() async {
    await _contactSubscription?.cancel();
    return super.close();
  }
}

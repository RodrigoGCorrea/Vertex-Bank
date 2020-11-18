import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:vertexbank/api/transfer.dart';
import 'package:vertexbank/models/failure.dart';

part 'addcontact_action_state.dart';

class AddContactActionCubit extends Cubit<AddContactActionState> {
  AddContactActionCubit({
    @required this.transferApi,
  }) : super(AddContactActionInitial());

  final TransferApi transferApi;

  void addContact(String userId, String email, String nickName) async {
    emit(AddContactActionInitial());
    try {
      emit(AddContactActionLoading());
      final contactInfo = await transferApi.findPossibleContact(email);
      await transferApi.addContact(userId, contactInfo.id, nickName);
      emit(AddContactActionFinished(message: "User added with success!"));
    } on Failure catch (e) {
      emit(AddContactActionError(error: e));
    }
  }
}

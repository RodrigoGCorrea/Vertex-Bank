import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:vertexbank/api/contact.dart';
import 'package:vertexbank/models/failure.dart';

part 'addcontact_action_state.dart';

class AddContactActionCubit extends Cubit<AddContactActionState> {
  AddContactActionCubit({
    @required this.contactApi,
  }) : super(AddContactActionInitial());

  final ContactApi contactApi;

  void addContact(String userId, String email, String nickName) async {
    emit(AddContactActionInitial());
    try {
      emit(AddContactActionLoading());
      final contactInfo = await contactApi.findPossibleContact(email);
      await contactApi.addContact(
        userId,
        contactInfo.id,
        nickName == ""
            ? "${contactInfo.name} ${contactInfo.lastName}"
            : nickName,
      );
      emit(AddContactActionFinished(message: "User added with success!"));
    } on Failure catch (e) {
      emit(AddContactActionError(error: e));
    }
  }
}

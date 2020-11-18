import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:vertexbank/models/inputs/email.dart';
import 'package:vertexbank/models/inputs/name.dart';

part 'addcontact_form_state.dart';

class AddContactFormCubit extends Cubit<AddContactFormState> {
  AddContactFormCubit() : super(AddContactFormState.empty);

  void setContactFormToSent() {
    emit(
      state.copyWith(stage: AddContactFormStage.sent),
    );
    nickNameContactChanged(state.nickNameContact.value);
    contactEmailChanged(state.emailContact.value);
  }

  void nickNameContactChanged(String nickName) {
    final bool isValid = Name.validate(nickName);
    emit(
      state.copyWith(
        nickNameContact: Name(nickName, isValid: isValid),
      ),
    );
  }

  void contactEmailChanged(String email) {
    final bool isValid = Email.validate(email);
    emit(
      state.copyWith(
        emailContact: Email(email, isValid: isValid),
      ),
    );
  }
}

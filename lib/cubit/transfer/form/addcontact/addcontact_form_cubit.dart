import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:vertexbank/models/inputs/email.dart';

part 'addcontact_form_state.dart';

class AddContactFormCubit extends Cubit<AddContactFormState> {
  AddContactFormCubit() : super(AddContactFormState.empty);

  void setContactFormToSentIfValid() {
    emit(
      state.copyWith(stage: AddContactFormStage.sent),
    );
  }

  void setContactFormToSentIfNotValid() {
    emit(state.copyWith(stage: AddContactFormStage.sent));
    nickNameContactChanged(state.nickNameContact);
    contactEmailChanged(state.emailContact.value);
  }

  void nickNameContactChanged(String nickName) {
    emit(
      state.copyWith(
        nickNameContact: nickName,
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

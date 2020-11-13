import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:vertexbank/models/inputs/email.dart';
import 'package:vertexbank/models/inputs/name.dart';
import 'package:vertexbank/models/inputs/password.dart';
import 'package:vertexbank/models/user.dart';

part 'signup_form_state.dart';

class SignUpFormCubit extends Cubit<SignUpFormState> {
  SignUpFormCubit() : super(SignUpFormState.empty);

  void cleanUp() {
    emit(SignUpFormState.empty);
  }

  void setSignUpFormNextAndRefresh() {
    emit(state.copyWith(
      stage: SignUpStage.next,
    ));
    // This is to refresh the inputs
    emailChanged(state.email.value);
    passwordChanged(state.password.value);
    passwordConfirmChanged(state.confirmPassword.value);
  }

  void setSignUpFormFinishAndRefresh() {
    final User user = User(
      email: state.email.value,
      name: state.name.value,
      lastName: state.lastName.value,
      birth: state.birth.toString(),
      money: 0,
      id: "",
    );
    emit(state.copyWith(
      stage: SignUpStage.finish,
      finishedUser: user,
    ));
    // This is to refresh the inputs
    nameChanged(state.name.value);
    lastNameChanged(state.lastName.value);
    birthChanged(birthParsed: state.birth);
  }

  void emailChanged(String email) {
    final isValid = Email.validate(email);
    final newEmail = Email(email, isValid: isValid);
    emit(
      state.copyWith(
        email: newEmail,
      ),
    );
  }

  void passwordChanged(String password) {
    final isValid = Password.validate(password);
    final newPassword = Password(password, isValid: isValid);
    emit(
      state.copyWith(
        password: newPassword,
      ),
    );
  }

  void passwordConfirmChanged(String confPassword) {
    bool isValid;
    String errorText;
    Password newConfPassword;

    if (state.password.value != confPassword) {
      isValid = false;
      errorText = Password.mustMatch;
    } else if (!Password.validate(confPassword)) {
      isValid = false;
      errorText = Password.minChar;
    } else {
      isValid = true;
      errorText = Password.minChar;
    }

    newConfPassword = Password(
      confPassword,
      isValid: isValid,
      errorText: errorText,
    );
    emit(
      state.copyWith(
        confirmPassword: newConfPassword,
      ),
    );
  }

  void nameChanged(String name) {
    final isValid = Name.validate(name);
    final newName = Name(name, isValid: isValid);
    emit(
      state.copyWith(
        name: newName,
      ),
    );
  }

  void lastNameChanged(String lastName) {
    final isValid = Name.validate(lastName);
    final newLastName = Name(lastName, isValid: isValid);
    emit(
      state.copyWith(
        lastName: newLastName,
      ),
    );
  }

  void birthChanged({String birth, DateTime birthParsed}) {
    //NOTE(Geraldo): Não sei se o parse retorna algum tipo de erro...
    DateTime parsedBirth;
    if (birth != null) parsedBirth = DateFormat("dd/MM/yyyy").parse(birth);

    emit(
      state.copyWith(
        birth: birthParsed ?? parsedBirth,
      ),
    );
  }
}

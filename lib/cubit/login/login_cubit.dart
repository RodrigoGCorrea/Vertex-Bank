import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:vertexbank/models/inputs/email.dart';
import 'package:vertexbank/models/inputs/password.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.empty);

  void setLoginFormAndRefresh() {
    emit(state.copyWith(stage: LoginStage.sent));

    // This is to refresh the password and email input
    emailChanged(state.email.value);
    passwordChanged(state.password.value);
  }

  void cleanUp() {
    emit(LoginState.empty);
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
}

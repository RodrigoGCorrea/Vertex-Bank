import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vertexbank/cubit/auth/auth_cubit.dart';

import 'package:vertexbank/models/inputs/email.dart';
import 'package:vertexbank/models/inputs/password.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    @required this.authCubit,
  }) : super(LoginState.empty);

  final AuthCubit authCubit;

  void finishLogin() {
    if (state.email.isValid && state.password.isValid) {
      authCubit.logIn(state.email.value, state.password.value);
      emit(state.copyWith(stage: LoginStage.sent));
    } else {
      // This is to refresh the password and email input
      emit(state.copyWith(stage: LoginStage.sent));
      emailChanged(state.email.value);
      passwordChanged(state.password.value);
    }
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

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:vertexbank/api/auth.dart';
import 'package:vertexbank/models/inputs/email.dart';
import 'package:vertexbank/models/inputs/password.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    @required AuthApi authApi,
  })  : assert(authApi != null),
        _authApi = authApi,
        super(LoginInital(
          email: Email(""),
          password: Password(""),
          wasSent: false,
        ));

  final AuthApi _authApi;

  Future<void> finishLogin() async {
    final lstate = state as LoginInital;

    if (lstate.email.isValid && lstate.password.isValid) {
      try {
        await _authApi.logInWithEmailAndPassword(
          email: lstate.email.value,
          password: lstate.password.value,
        );
        emit(lstate.copyWith(wasSent: true));
      } catch (e) {
        throw (e);
      }
    } else {
      // This is to refresh the password and email input
      emit(lstate.copyWith(wasSent: true));
      emailChanged(lstate.email.value);
      passwordChanged(lstate.password.value);
    }
  }

  void emailChanged(String email) {
    final lstate = state as LoginInital;
    final isValid = Email.validate(email);
    final newEmail = Email(email, isValid: isValid);

    emit(
      lstate.copyWith(
        email: newEmail,
      ),
    );
  }

  void passwordChanged(String password) {
    final lstate = state as LoginInital;
    final isValid = Password.validate(password);
    final newPassword = Password(password, isValid: isValid);

    emit(
      lstate.copyWith(
        password: newPassword,
      ),
    );
  }
}

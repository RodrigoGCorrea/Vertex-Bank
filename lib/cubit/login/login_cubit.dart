import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:vertexbank/api/auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    @required AuthApi authApi,
  })  : assert(authApi != null),
        _authApi = authApi,
        super(LoginInital(
          email: "",
          password: "",
          wasSent: false,
        ));

  final AuthApi _authApi;

  Future<void> finishLogin() async {
    final lstate = state as LoginInital;
    try {
      await _authApi.logInWithEmailAndPassword(
        email: lstate.email,
        password: lstate.password,
      );
      emit(lstate.copyWith(
        wasSent: true,
      ));
    } catch (e) {
      throw (e);
    }
  }

  void emailChanged(String email) {
    final lstate = state as LoginInital;
    emit(
      lstate.copyWith(
        email: email,
      ),
    );
  }

  void passChanged(String password) {
    final lstate = state as LoginInital;
    emit(
      lstate.copyWith(
        password: password,
      ),
    );
  }
}

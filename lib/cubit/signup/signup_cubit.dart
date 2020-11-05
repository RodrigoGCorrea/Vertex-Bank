import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:vertexbank/models/user.dart';
import 'package:vertexbank/api/auth.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit({
    @required AuthApi authApi,
  })  : assert(authApi != null),
        _authApi = authApi,
        super(SignupInitial(
          user: User.empty,
          password: "",
          confirmPassword: "",
        ));

  final AuthApi _authApi;

  Future<void> finishSignUp() async {
    final lstate = state as SignupInitial;
    try {
      await _authApi.signUp(
        user: lstate.user,
        password: lstate.confirmPassword,
      );
      emit(SignupFinish());
    } catch (e) {
      throw (e);
    }
  }

  void emailChanged(String email) {
    final lstate = state as SignupInitial;
    emit(
      lstate.copyWith(
        user: lstate.user.copyWith(email: email),
      ),
    );
  }

  void passChanged(String pass) {
    final lstate = state as SignupInitial;
    emit(
      lstate.copyWith(
        password: pass,
      ),
    );
  }

  void passConfirmChanged(String confPass) {
    final lstate = state as SignupInitial;
    emit(
      lstate.copyWith(
        confirmPassword: confPass,
      ),
    );
  }

  void goToFinalStage() {
    final lstate = state as SignupInitial;
    emit(
      lstate.copyWith(
        stage: SignupStage.last,
      ),
    );
  }

  void nameChanged(String name) {
    final lstate = state as SignupInitial;
    emit(
      lstate.copyWith(
        user: lstate.user.copyWith(name: name),
      ),
    );
  }

  void lastNameChanged(String lastName) {
    final lstate = state as SignupInitial;
    emit(
      lstate.copyWith(
        user: lstate.user.copyWith(lastName: lastName),
      ),
    );
  }

  void birthChanged(String birth) {
    final lstate = state as SignupInitial;
    emit(
      lstate.copyWith(
        user: lstate.user.copyWith(birth: birth),
      ),
    );
  }
}

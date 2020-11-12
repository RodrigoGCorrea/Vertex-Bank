import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:vertexbank/api/auth.dart';
import 'package:vertexbank/models/failure.dart';
import 'package:vertexbank/models/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    @required AuthApi authApi,
  })  : assert(authApi != null),
        _authApi = authApi,
        super(UnauthenticatedState());

  final AuthApi _authApi;

  void getSignedInUser() async {
    try {
      final user = await _authApi.user;
      if (user == null)
        emit(UnauthenticatedState());
      else
        emit(AuthenticatedState(user: user));
    } on Failure catch (e) {
      emit(ErrorState(error: e));
    }
  }

  User getSignedInUserWithoutEmit() {
    final lstate = state as AuthenticatedState;
    if (state is AuthenticatedState)
      return lstate.user;
    else
      return null;
  }

  void signUp(User user, String password) async {
    try {
      await _authApi.signUp(
        user: user,
        password: password,
      );
      emit(AuthenticatedState(user: user));
    } on Failure catch (e) {
      emit(ErrorState(error: e));
    }
  }

  void logIn(String email, String password) async {
    try {
      await _authApi.logInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = await _authApi.user;
      if (user == null)
        emit(UnauthenticatedState());
      else
        emit(AuthenticatedState(user: user));
    } on Failure catch (e) {
      emit(ErrorState(error: e));
    }
  }

  void signOut() async {
    try {
      await _authApi.logOut();
      emit(UnauthenticatedState());
    } on Failure catch (e) {
      emit(ErrorState(error: e));
    }
  }
}

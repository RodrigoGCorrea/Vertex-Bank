import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:vertexbank/api/auth.dart';
import 'package:vertexbank/models/failure.dart';
import 'package:vertexbank/models/user.dart';

part 'auth_action_state.dart';

class AuthActionCubit extends Cubit<AuthActionState> {
  AuthActionCubit({
    @required AuthApi authApi,
  })  : assert(authApi != null),
        _authApi = authApi,
        super(AuthActionInitial());

  final AuthApi _authApi;

  void getSignedInUser() async {
    emit(AuthActionInitial());
    try {
      emit(AuthActionLoading());
      final user = await _authApi.user;
      if (user == null)
        emit(AuthActionUnauthenticated());
      else
        emit(AuthActionAuthenticated(user: user));
    } on Failure catch (e) {
      emit(AuthActionError(error: e));
    }
  }

  User getSignedInUserWithoutEmit() {
    if (state is AuthActionAuthenticated) {
      final lstate = state as AuthActionAuthenticated;
      return lstate.user;
    } else
      return null;
  }

  void signUp(User user, String password) async {
    emit(AuthActionInitial());
    try {
      emit(AuthActionLoading());
      await _authApi.signUp(
        user: user,
        password: password,
      );
      final loggedInUser = await _authApi.user;
      if (loggedInUser == null)
        emit(AuthActionUnauthenticated());
      else
        emit(AuthActionAuthenticated(user: loggedInUser));
    } on Failure catch (e) {
      emit(AuthActionError(error: e));
    }
  }

  void logIn(String email, String password) async {
    emit(AuthActionInitial());
    try {
      emit(AuthActionLoading());
      await _authApi.logInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = await _authApi.user;
      if (user == null)
        emit(AuthActionUnauthenticated());
      else
        emit(AuthActionAuthenticated(user: user));
    } on Failure catch (e) {
      emit(AuthActionError(error: e));
    }
  }

  void signOut() async {
    emit(AuthActionInitial());
    try {
      emit(AuthActionLoading());
      await _authApi.logOut();
      emit(AuthActionUnauthenticated());
    } on Failure catch (e) {
      emit(AuthActionError(error: e));
    }
  }
}

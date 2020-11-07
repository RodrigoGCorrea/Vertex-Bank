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

  Future<void> logIn(String email, String password) async {
    try {
      await _authApi.logInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthenticatedState(user: _authApi.user));
    } on Failure catch (e) {
      emit(ErrorState(e));
    }
  }

  Future<void> signOut() async {
    try {
      await _authApi.logOut();
      emit(UnauthenticatedState());
    } on Failure catch (e) {
      emit(ErrorState(e));
    }
  }
}

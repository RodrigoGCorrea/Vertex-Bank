import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:vertexbank/api/auth.dart';
import 'package:vertexbank/models/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    @required AuthApi authApi,
  })  : assert(authApi != null),
        _authApi = authApi,
        super(UnauthenticatedState());

  final AuthApi _authApi;

  void loginWasSuccessful() {
    emit(AuthenticatedState());
  }

  void signupWasSuccessful() {
    emit(AuthenticatedState());
  }

  Future<void> signOut() async {
    try {
      await _authApi.logOut();
      emit(UnauthenticatedState());
    } on Exception {
      emit(ErrorState());
    }
  }
}

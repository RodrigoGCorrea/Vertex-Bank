part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  void copyWith() {}
}

class ErrorState extends AuthState {
  @override
  List<Object> get props => [];
}

class UnauthenticatedState extends AuthState {
  const UnauthenticatedState({
    String email,
    String password,
  })  : this.email = email,
        this.password = password,
        super();

  final String email;
  final String password;

  @override
  UnauthenticatedState copyWith({
    String email,
    String password,
  }) {
    return UnauthenticatedState(
      email: this.email ?? email,
      password: this.password ?? password,
    );
  }

  @override
  List<Object> get props => [email, password];
}

class AuthenticatedState extends AuthState {
  const AuthenticatedState({
    Stream<User> user,
  })  : this.user = user,
        super();

  final Stream<User> user;

  @override
  List<Object> get props => [user];
}

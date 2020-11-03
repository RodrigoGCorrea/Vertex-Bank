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
  @override
  List<Object> get props => [];
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

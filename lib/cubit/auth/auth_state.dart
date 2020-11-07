part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class ErrorState extends AuthState {
  const ErrorState(
    this.error,
  );

  final Failure error;

  @override
  List<Object> get props => [error];
}

class UnauthenticatedState extends AuthState {}

class AuthenticatedState extends AuthState {
  const AuthenticatedState({
    Stream<User> user,
  })  : this.user = user,
        super();

  final Stream<User> user;

  @override
  List<Object> get props => [user];
}

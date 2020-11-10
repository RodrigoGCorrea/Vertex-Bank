part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class ErrorState extends AuthState {
  const ErrorState({
    @required this.error,
  });

  final Failure error;

  @override
  List<Object> get props => [error];
}

class UnauthenticatedState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthenticatedState extends AuthState {
  const AuthenticatedState({
    @required this.user,
  });

  final User user;

  @override
  List<Object> get props => [user];
}

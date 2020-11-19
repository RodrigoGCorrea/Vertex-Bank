part of 'auth_action_cubit.dart';

abstract class AuthActionState extends Equatable {
  const AuthActionState();

  @override
  List<Object> get props => [];
}

class AuthActionInitial extends AuthActionState {}

class AuthActionError extends AuthActionState {
  const AuthActionError({
    @required this.error,
  });

  final Failure error;

  @override
  List<Object> get props => [error];
}

class AuthActionUnauthenticated extends AuthActionState {}

class AuthActionLoading extends AuthActionState {}

class AuthActionAuthenticated extends AuthActionState {
  const AuthActionAuthenticated({
    @required this.user,
  });

  final User user;

  @override
  List<Object> get props => [user];
}

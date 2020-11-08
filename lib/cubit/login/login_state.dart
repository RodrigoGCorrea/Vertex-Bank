part of 'login_cubit.dart';

enum LoginStage { waiting, sent }

class LoginState extends Equatable {
  const LoginState({
    @required this.email,
    @required this.password,
    @required this.stage,
  });

  final Email email;
  final Password password;
  final LoginStage stage;

  static final empty = LoginState(
    email: Email(""),
    password: Password(""),
    stage: LoginStage.waiting,
  );

  LoginState copyWith({
    Email email,
    Password password,
    LoginStage stage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      stage: stage ?? this.stage,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        stage,
      ];
}

part of 'login_form_cubit.dart';

enum LoginStage { waiting, sent }

class LoginFormState extends Equatable {
  const LoginFormState({
    @required this.email,
    @required this.password,
    @required this.stage,
  });

  final Email email;
  final Password password;
  final LoginStage stage;

  static final empty = LoginFormState(
    email: Email(""),
    password: Password(""),
    stage: LoginStage.waiting,
  );

  LoginFormState copyWith({
    Email email,
    Password password,
    LoginStage stage,
  }) {
    return LoginFormState(
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

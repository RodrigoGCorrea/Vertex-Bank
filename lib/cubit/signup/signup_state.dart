part of 'signup_cubit.dart';

enum SignupStage { intial, next, finish }

class SignupState extends Equatable {
  const SignupState({
    @required this.email,
    @required this.name,
    @required this.lastName,
    @required this.birth,
    @required this.password,
    @required this.confirmPassword,
    @required this.stage,
    @required this.finishedUser,
  }) : super();

  final Email email;
  final Name name;
  final Name lastName;
  final DateTime birth;
  final Password password;
  final Password confirmPassword;
  final SignupStage stage;
  final User finishedUser;

  static final SignupState empty = SignupState(
    email: Email(""),
    name: Name(""),
    lastName: Name(""),
    birth: null,
    password: Password(""),
    confirmPassword: Password(""),
    stage: SignupStage.intial,
    finishedUser: User.empty,
  );

  SignupState copyWith({
    Email email,
    Name name,
    Name lastName,
    DateTime birth,
    Password password,
    Password confirmPassword,
    SignupStage stage,
    User finishedUser,
  }) {
    return SignupState(
      email: email ?? this.email,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      birth: birth ?? this.birth,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      stage: stage ?? this.stage,
      finishedUser: finishedUser ?? this.finishedUser,
    );
  }

  @override
  List<Object> get props {
    return [
      email,
      name,
      lastName,
      birth,
      password,
      confirmPassword,
      stage,
      finishedUser,
    ];
  }
}

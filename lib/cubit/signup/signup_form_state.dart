part of 'signup_form_cubit.dart';

enum SignUpStage { intial, next, finishFail, finishOk }

class SignUpFormState extends Equatable {
  const SignUpFormState({
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
  final Birthday birth;
  final Password password;
  final Password confirmPassword;
  final SignUpStage stage;
  final User finishedUser;

  static final SignUpFormState empty = SignUpFormState(
    email: Email(""),
    name: Name(""),
    lastName: Name(""),
    birth: Birthday(null),
    password: Password(""),
    confirmPassword: Password(""),
    stage: SignUpStage.intial,
    finishedUser: User.empty,
  );

  SignUpFormState copyWith({
    Email email,
    Name name,
    Name lastName,
    Birthday birth,
    Password password,
    Password confirmPassword,
    SignUpStage stage,
    User finishedUser,
  }) {
    return SignUpFormState(
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

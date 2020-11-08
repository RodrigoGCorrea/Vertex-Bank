part of 'signup_cubit.dart';

enum SingupSentFrom { intial, next, nextFinish, finish }

abstract class SignupState extends Equatable {
  const SignupState();
}

class SignupInitial extends SignupState {
  const SignupInitial({
    @required this.email,
    @required this.name,
    @required this.lastName,
    @required this.birth,
    @required this.password,
    @required this.confirmPassword,
    @required this.wasSent,
  }) : super();

  final Email email;
  final Name name;
  final Name lastName;
  final DateTime birth;
  final Password password;
  final Password confirmPassword;
  final SingupSentFrom wasSent;

  static final SignupInitial empty = SignupInitial(
    email: Email(""),
    name: Name(""),
    lastName: Name(""),
    birth: null,
    password: Password(""),
    confirmPassword: Password(""),
    wasSent: SingupSentFrom.intial,
  );

  SignupInitial copyWith({
    Email email,
    Name name,
    Name lastName,
    DateTime birth,
    Password password,
    Password confirmPassword,
    SingupSentFrom wasSent,
  }) {
    return SignupInitial(
      email: email ?? this.email,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      birth: birth ?? this.birth,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      wasSent: wasSent ?? this.wasSent,
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
      wasSent,
    ];
  }
}

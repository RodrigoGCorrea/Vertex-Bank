part of 'signup_cubit.dart';

enum SignupStage { first, last }

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {
  SignupInitial({
    this.user,
    this.password,
    this.confirmPassword,
    this.stage,
  }) : super();

  final User user;
  final String password;
  final String confirmPassword;
  final SignupState stage;

  SignupInitial copyWith({
    User user,
    String password,
    String confirmPassword,
    SignupStage stage,
  }) {
    return SignupInitial(
      user: user ?? this.user,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.password,
      stage: stage ?? this.stage,
    );
  }

  @override
  List<Object> get props => [
        user,
        password,
        confirmPassword,
      ];
}

class SignupFinish extends SignupState {}

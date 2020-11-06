part of 'login_cubit.dart';

abstract class LoginState extends Equatable {}

class LoginInital extends LoginState {
  LoginInital({
    @required this.email,
    @required this.password,
    @required this.wasSent,
  });

  final String email;
  final String password;
  final bool wasSent;

  LoginInital copyWith({
    String email,
    String password,
    bool wasSent,
  }) {
    return LoginInital(
      email: email ?? this.email,
      password: password ?? this.password,
      wasSent: wasSent ?? this.wasSent,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        wasSent,
      ];
}

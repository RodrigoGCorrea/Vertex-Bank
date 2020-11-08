import 'package:meta/meta.dart';

class User {
  const User({
    @required this.id,
    @required this.email,
    @required this.name,
    @required this.lastName,
    @required this.birth,
    @required this.money,
  });

  final String id;
  final String email;
  final String name;
  final String lastName;
  final String birth;
  final int money;

  User copyWith({
    String id,
    String email,
    String name,
    String lastName,
    String birth,
    int money,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      birth: birth ?? this.birth,
      money: money ?? this.money,
    );
  }

  static User empty = User(
    id: "",
    email: "",
    name: "",
    lastName: "",
    birth: "",
    money: 0,
  );
}

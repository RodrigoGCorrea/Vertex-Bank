import 'package:flutter/cupertino.dart';

class User {
  const User({
    @required this.id,
    @required this.email,
    @required this.name,
    @required this.lastName,
    @required this.birth,
  });

  final String id;
  final String email;
  final String name;
  final String lastName;
  final String birth;

  User copyWith({
    String id,
    String email,
    String name,
    String lastName,
    String birth,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      birth: birth ?? this.birth,
    );
  }

  static User empty = User(
    id: "",
    email: "",
    name: "",
    lastName: "",
    birth: "",
  );
}

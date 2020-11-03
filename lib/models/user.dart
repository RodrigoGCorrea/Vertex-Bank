import 'package:meta/meta.dart';

class User {
  const User({
    @required this.id,
    @required this.name,
    @required this.email,
  });

  final String id;
  final String name;
  final String email;

  static User empty = User(email: "", name: "", id: "");
}

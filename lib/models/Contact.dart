import 'package:meta/meta.dart';

class Contact {
  final String id;
  final String nickname;
  final DateTime dateAdded;

  const Contact({
    @required this.id,
    @required this.dateAdded,
    this.nickname,
  });

  static final dbFields = {
    "id": "id",
    "dateAdded": "dateAdded",
    "nickname": "nickname",
  };
}

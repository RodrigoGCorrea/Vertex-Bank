import 'package:meta/meta.dart';

class Contact {
  final String nickname;
  final String userID;

  const Contact({
    @required this.userID,
    this.nickname,
  });
}

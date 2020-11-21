import 'dart:convert';
import 'package:meta/meta.dart';

class ECheck {
  final String senderID;
  final int amount;
  final String checkID;

  ECheck({
    @required this.senderID,
    @required this.amount,
    @required this.checkID,
  });

  static final dbFields = {
    "amount": "amount",
  };

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'amount': amount,
      'checkID': checkID,
    };
  }

  factory ECheck.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ECheck(
      senderID: map['senderID'],
      amount: map['amount'],
      checkID: map['checkID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ECheck.fromJson(String source) => ECheck.fromMap(json.decode(source));
}

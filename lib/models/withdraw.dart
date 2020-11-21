import 'dart:convert';
import 'package:meta/meta.dart';

class Withdraw {
  final String senderID;
  final int amount;
  final String checkID;

  Withdraw({
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

  factory Withdraw.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Withdraw(
      senderID: map['senderID'],
      amount: map['amount'],
      checkID: map['checkID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Withdraw.fromJson(String source) =>
      Withdraw.fromMap(json.decode(source));
}

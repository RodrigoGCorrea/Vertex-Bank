import 'package:vertexbank/models/inputs/money_amount.dart';

class Transaction {
  final String id;
  final String targetUser;
  final bool received;
  final MoneyAmount amount;
  final DateTime date;

  const Transaction({
    this.id,
    this.targetUser,
    this.amount,
    this.date,
    this.received,
  });

  static final empty = Transaction(
    id: "",
    targetUser: "",
    received: null,
    amount: MoneyAmount(0),
    date: DateTime(1989, DateTime.november, 9),
  );

  static final dbFields = {
    "id": "id",
    "targetUser": "targetUser",
    "received": "received",
    "amount": "amount",
    "date": "date",
  };
}

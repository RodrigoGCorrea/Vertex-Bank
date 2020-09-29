class Transaction {
  final String id;
  final String name;
  final bool received;
  final String amount;
  final DateTime date;

  Transaction({
    this.id,
    this.name,
    this.amount,
    this.date,
    this.received,
  });
}

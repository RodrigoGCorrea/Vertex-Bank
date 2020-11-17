import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:vertexbank/models/failure.dart';
import 'package:vertexbank/models/transaction.dart';

class TransactionListApi {
  final _db = firestore.FirebaseFirestore.instance;

  final userCollection = 'users';
  final transactionCollection = 'transactions';

  Stream<List<Transaction>> watchTransactionList(String id) async* {
    try {
      yield* _db
          .collection(userCollection)
          .doc(id)
          .collection(transactionCollection)
          .snapshots()
          .map((snapshot) {
        List<Transaction> transactions = [];
        snapshot.docs.forEach((t) {
          final transaction = Transaction(
            id: t.id,
            targetUser: t.get('${Transaction.dbFields["targetUser"]}'),
            received: t.get('${Transaction.dbFields["received"]}'),
            amount: t.get('${Transaction.dbFields["amount"]}'),
            date: t.get('${Transaction.dbFields["date"]}').toDate(),
          );
          transactions.add(transaction);
        });
        return transactions;
      });
    } on Error {
      //This should never reach, firestore doesn't throw when a collection doesn't exists
      throw Failure("You don't have any transactions...");
    }
  }
}

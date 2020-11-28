import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:vertexbank/models/failure.dart';
import 'package:vertexbank/models/transaction.dart';
import 'package:vertexbank/models/user.dart';

class TransferApi {
  final _db = firestore.FirebaseFirestore.instance;

  final userCollection = 'users';
  final transactionCollection = 'transactions';
  final moneyField = User.dbFields["money"];

  Future<void> makeTransfer(
    String idSender,
    String idReceiver,
    Transaction transactionSender,
    Transaction transactionReceiver,
  ) async {
    try {
      final sender = await _db.collection(userCollection).doc(idSender).get();
      final senderMoney = await sender.get(moneyField);
      final transactionMoney = transactionSender.amount;
      if (senderMoney < transactionMoney) {
        throw Failure("You don't have enough money...");
      }

      final receiver =
          await _db.collection(userCollection).doc(idReceiver).get();
      final receiverMoney = await receiver.get(moneyField);

      await _db
          .collection(userCollection)
          .doc(idSender)
          .update({"$moneyField": senderMoney - transactionMoney});

      await _db
          .collection(userCollection)
          .doc(idSender)
          .collection(transactionCollection)
          .add({
        "${Transaction.dbFields["targetUser"]}": transactionSender.targetUser,
        "${Transaction.dbFields["received"]}": transactionSender.received,
        "${Transaction.dbFields["amount"]}": transactionMoney,
        "${Transaction.dbFields["date"]}": transactionSender.date,
      });

      await _db
          .collection(userCollection)
          .doc(idReceiver)
          .collection(transactionCollection)
          .add({
        "${Transaction.dbFields["targetUser"]}": transactionReceiver.targetUser,
        "${Transaction.dbFields["received"]}": transactionReceiver.received,
        "${Transaction.dbFields["amount"]}": transactionMoney,
        "${Transaction.dbFields["date"]}": transactionReceiver.date,
      });

      await _db
          .collection(userCollection)
          .doc(idReceiver)
          .update({"$moneyField": receiverMoney + transactionMoney});
    } on Error catch (e) {
      //This should never reach!!
      throw Failure("Couldn't make payment... $e");
    }
  }
}

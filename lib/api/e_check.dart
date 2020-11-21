import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:vertexbank/models/failure.dart';
import 'package:vertexbank/models/transaction.dart';

import 'package:vertexbank/models/user.dart';
import 'package:vertexbank/models/e_check.dart';

class ECheckApi {
  final _db = firestore.FirebaseFirestore.instance;

  final userCollection = 'users';
  final eCheckCollection = 'echeck';
  final transactionCollection = 'transactions';
  final moneyField = User.dbFields["money"];
  final amountField = ECheck.dbFields["amount"];

  Future<ECheck> makeECheck(
    String senderId,
    int amountToCheck,
  ) async {
    try {
      final sender = await _db.collection(userCollection).doc(senderId).get();
      final amountOfUser = await sender.get(moneyField);
      final date = DateTime.now();

      if (amountOfUser < amountToCheck)
        throw Failure("You don't have enough money...");

      await _db
          .collection(userCollection)
          .doc(senderId)
          .update({"$moneyField": amountOfUser - amountToCheck});

      await _db
          .collection(userCollection)
          .doc(senderId)
          .collection(transactionCollection)
          .add({
        "${Transaction.dbFields["targetUser"]}": "new E-Check",
        "${Transaction.dbFields["received"]}": false,
        "${Transaction.dbFields["amount"]}": amountToCheck,
        "${Transaction.dbFields["date"]}": date,
      });

      final generatedCheck = await _db
          .collection(userCollection)
          .doc(senderId)
          .collection(eCheckCollection)
          .add({"$amountField": amountToCheck});

      return fromDocSnapToWithdraw(await generatedCheck.get(), senderId);
    } on Error catch (e) {
      //This should never reach!!!
      throw Failure(e.toString());
    }
  }

  Future<ECheck> getECheck(String senderId, String checkId) async {
    try {
      final check = await _db
          .collection(userCollection)
          .doc(senderId)
          .collection(eCheckCollection)
          .doc(checkId)
          .get();

      if (!check.exists) throw Failure("This check was used.");

      return fromDocSnapToWithdraw(check, senderId);
    } on Error catch (e) {
      //This should never reach!!!
      throw Failure(e.toString());
    }
  }

  ECheck fromDocSnapToWithdraw(
      firestore.DocumentSnapshot eCheck, String senderId) {
    return ECheck(
        senderID: senderId,
        amount: eCheck.get(amountField),
        checkID: eCheck.id);
  }
}

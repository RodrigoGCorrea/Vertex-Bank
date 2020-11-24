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

  Future<void> depositCheck(ECheck eCheck, String receiverId) async {
    try {
      await isCheckValid(eCheck.senderID, eCheck.checkID);

      final date = DateTime.now();
      final receiver =
          await _db.collection(userCollection).doc(receiverId).get();
      final receiverAmount = await receiver.get(moneyField);

      await _db
          .collection(userCollection)
          .doc(receiverId)
          .update({"$moneyField": receiverAmount + eCheck.amount});

      await _db
          .collection(userCollection)
          .doc(receiverId)
          .collection(transactionCollection)
          .add({
        "${Transaction.dbFields["targetUser"]}": "received E-Check",
        "${Transaction.dbFields["received"]}": true,
        "${Transaction.dbFields["amount"]}": eCheck.amount,
        "${Transaction.dbFields["date"]}": date,
      });

      await _db
          .collection(userCollection)
          .doc(eCheck.senderID)
          .collection(eCheckCollection)
          .doc(eCheck.checkID)
          .delete();
    } on Failure {
      rethrow;
    } on Error catch (e) {
      //This should never reach!!!
      throw Failure(e.toString());
    }
  }

  Future<String> getCheckOwnerName(String senderId) async {
    try {
      final user = await _db.collection(userCollection).doc(senderId).get();
      final name = await user.get(User.dbFields["name"]);
      final lastName = await user.get(User.dbFields["lastName"]);

      return "$name $lastName";
    } on Error catch (e) {
      //This should never reach!!!
      throw Failure(e.toString());
    }
  }

  Future<void> isCheckValid(String senderId, String checkId) async {
    try {
      final check = await _db
          .collection(userCollection)
          .doc(senderId)
          .collection(eCheckCollection)
          .doc(checkId)
          .get();

      if (!check.exists) throw Failure("This check was used.");
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

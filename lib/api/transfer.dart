import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:vertexbank/models/contact.dart';
import 'package:vertexbank/models/failure.dart';
import 'package:vertexbank/models/transaction.dart';
import 'package:vertexbank/models/user.dart';
import 'package:vertexbank/api/common/user.dart';

class TransferApi {
  final _db = firestore.FirebaseFirestore.instance;

  final contactCollection = 'contacts';
  final userCollection = 'users';
  final transactionCollection = 'transactions';
  final moneyField = User.dbFields["money"];
  final nickNameField = 'nickName';
  final emailField = User.dbFields["email"];

  Future<void> makeTransfer(
    String idSender,
    String idReceiver,
    Transaction transactionSender,
    Transaction transactionReceiver,
  ) async {
    try {
      final sender = await _db.collection(userCollection).doc(idSender).get();
      final senderMoney = await sender.get(moneyField);
      final transactionMoney = (transactionSender.amount.value * 100).toInt();
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

  Future<List<Contact>> getContacts(String id) async {
    try {
      List<Contact> contacts = [];

      //Queries always returns null if the collection or doc doesn't exists
      await _db
          .collection(userCollection)
          .doc(id)
          .collection(contactCollection)
          .get()
          .then((snapshot) => snapshot.docs.forEach((doc) {
                final contact = Contact(doc.get(nickNameField), userID: doc.id);
                contacts.add(contact);
              }));

      return contacts;
    } on Error catch (e) {
      //This should never reach!!
      throw Failure("Couldn't get the contact list. $e");
    }
  }

  Future<void> addContact(
      String userId, String contactId, String nickName) async {
    final contact = Contact(nickName, userID: contactId);
    try {
      await _db
          .collection(userCollection)
          .doc(userId)
          .collection(contactCollection)
          .doc(contact.userID)
          .set({
        "$nickNameField": contact.nickname,
      });
    } on Error {
      //This should never reach!
      throw Failure("Couldn't add the contact.");
    }
  }

  Future<User> findPossibleContact(String email) async {
    try {
      //This should only returns ONE user!!!
      final possible = await _db
          .collection(userCollection)
          .where(emailField, isEqualTo: email)
          .get();

      if (possible.docs.isEmpty) throw Failure("This user doesn't exists.");

      return UserCommonApi.fromDocToUser(possible.docs.first);
    } on Error {
      throw Failure("This user doesn't exists.");
    }
  }
}

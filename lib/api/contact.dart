import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:vertexbank/api/common/user.dart';
import 'package:vertexbank/models/contact.dart';
import 'package:vertexbank/models/failure.dart';
import 'package:vertexbank/models/user.dart';

class ContactApi {
  final _db = firestore.FirebaseFirestore.instance;

  final userCollection = 'users';
  final contactCollection = 'contacts';
  final emailField = User.dbFields["email"];

  Stream<List<Contact>> watchContactList(String id) async* {
    try {
      yield* _db
          .collection(userCollection)
          .doc(id)
          .collection(contactCollection)
          .orderBy('dateAdded', descending: true)
          .snapshots()
          .map((snapshot) {
        List<Contact> contacts = [];
        snapshot.docs.forEach((c) {
          final transaction = Contact(
            id: c.id,
            nickname: c.get(Contact.dbFields["nickname"]),
            dateAdded: c.get(Contact.dbFields["dateAdded"]).toDate(),
          );
          contacts.add(transaction);
        });
        return contacts;
      });
    } on Error {
      //This should never reach, firestore doesn't throw when a collection doesn't exists
      throw Failure("You don't have any transactions...");
    }
  }

  Future<void> addContact(
    String userId,
    String contactId,
    String nickName,
  ) async {
    if (userId == contactId) throw Failure("You can't add yourself.");
    final contact =
        Contact(nickname: nickName, id: contactId, dateAdded: DateTime.now());
    try {
      await _db
          .collection(userCollection)
          .doc(userId)
          .collection(contactCollection)
          .doc(contact.id)
          .set({
        "${Contact.dbFields["nickname"]}": contact.nickname,
        "${Contact.dbFields["dateAdded"]}": contact.dateAdded,
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

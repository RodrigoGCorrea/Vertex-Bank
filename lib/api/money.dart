import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

import 'package:vertexbank/models/user.dart';

class MoneyApi {
  final _db = firestore.FirebaseFirestore.instance;

  final userCollection = 'users';
  final moneyField = User.dbFields["money"];

  Stream<int> watchMoneyFromUser(String id) async* {
    yield* _db.collection(userCollection).doc(id).snapshots().map((snapshot) {
      return snapshot.get(moneyField);
    });
  }
}

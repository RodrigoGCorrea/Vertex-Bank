import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

import 'package:vertexbank/models/user.dart';

class MoneyApi {
  final _db = firestore.FirebaseFirestore.instance;

  final userCollection = 'users';
  final moneyField = User.dbFields["money"];

  Stream<double> watchMoneyFromUser(String id) async* {
    yield* _db.collection(userCollection).doc(id).snapshots().map((snapshot) {
      var money = snapshot.get(moneyField);
      if (money is int) money = money.toDouble();
      return money;
    });
  }
}

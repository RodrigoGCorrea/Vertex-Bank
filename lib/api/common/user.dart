import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vertexbank/models/failure.dart';
import 'package:vertexbank/models/user.dart';

class UserCommonApi {
  static final _db = FirebaseFirestore.instance;

  static final userCollection = 'users';

  static Future<User> fromDbToUser(String id) async {
    try {
      final user = await _db.collection(userCollection).doc(id).get();
      return User(
        id: id,
        email: user.get(User.dbFields["email"]),
        name: user.get(User.dbFields["name"]),
        lastName: user.get(User.dbFields["lastName"]),
        birth: user.get(User.dbFields["birth"]),
        money: user.get(User.dbFields["money"]),
      );
    } on Error {
      throw InnerFailure("Error finding user: $id");
    }
  }

  static Future<User> fromDocToUser(DocumentSnapshot user) async {
    try {
      return User(
        id: user.id,
        email: user.get(User.dbFields["email"]),
        name: user.get(User.dbFields["name"]),
        lastName: user.get(User.dbFields["lastName"]),
        birth: user.get(User.dbFields["birth"]),
        money: user.get(User.dbFields["money"]).toInt(),
      );
    } on Error catch (e) {
      throw InnerFailure(
          "Error finding user: ${user.id}. With the follwing error: $e");
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:meta/meta.dart';

import 'package:vertexbank/models/user.dart';
import 'package:vertexbank/models/failure.dart';

class AuthApi {
  AuthApi({
    firebase_auth.FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<User> get user async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return null;
    try {
      final user = await _db.collection('users').doc(firebaseUser.uid).get();
      return User(
        id: user.id,
        birth: await user.get('birth'),
        email: await user.get('email'),
        lastName: await user.get('lastName'),
        money: await user.get('money'),
        name: await user.get('name'),
      );
    } on Error {
      //This should never reach!!
      throw Failure("Failed to get logged user");
    }
  }

  Future<void> signUp({
    @required User user,
    @required String password,
  }) async {
    assert(user.email != null && password != null);
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      await _db.collection('users').doc(_firebaseAuth.currentUser.uid).set({
        'email': user.email,
        'name': user.name,
        'lastName': user.lastName,
        'money': user.money,
        'birth': user.birth,
      });
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use')
        throw Failure("Email already in use!");
      else if (e.code == 'invalid-email')
        throw Failure("Invalid email!");
      else
        throw Failure("Server error!");
    }
  }

  Future<void> logInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password')
        throw Failure("User not found!");
      else
        throw Failure("Server error!");
    }
  }

  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } on Exception {
      throw Failure("Error on logout!");
    }
  }
}

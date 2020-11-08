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

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final User modelUser = User(
        id: firebaseUser.uid,
        email: firebaseUser.email,
        name: "",
        birth: "",
        lastName: "",
      );

      return firebaseUser == null ? User.empty : modelUser;
    });
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpFailure] if an exception occurs.
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
        'birth': user.birth,
      });
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use')
        throw Failure("Email already in use!");
      else
        throw Failure("Server error!");
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
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

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } on Exception {
      throw Failure("Error on logout!");
    }
  }
}

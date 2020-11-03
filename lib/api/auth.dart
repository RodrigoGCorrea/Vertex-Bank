import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:meta/meta.dart';

import 'package:vertexbank/models/user.dart';

class AuthApi {
  AuthApi({
    firebase_auth.FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final User modelUser = User(
          id: firebaseUser.uid,
          email: firebaseUser.email,
          name: firebaseUser.displayName);

      return firebaseUser == null ? User.empty : modelUser;
    });
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpFailure] if an exception occurs.
  Future<void> signUp({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      //throw SignUpFailure();
      //NOTE(Geraldo): Lidar com erros, não sei se usar uma classe pra isso é a
      //               melhor maneira
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
    } on Exception {
      //throw LogInWithEmailAndPasswordFailure();
      //NOTE(Geraldo): Lidar com erros, não sei se usar uma classe pra isso é a
      //               melhor maneira
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } on Exception {
      //throw LogOutFailure();
      //NOTE(Geraldo): Lidar com erros, não sei se usar uma classe pra isso é a
      //               melhor maneira
    }
  }
}

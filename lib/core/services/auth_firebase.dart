import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  User get currentUser;
  Future<User> signInAnonymously();
  Future<void> signOut();
  Stream<User> authStateChanges();
}

class AuthFirebase implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  User get currentUser => _firebaseAuth.currentUser;

  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  Future<User> signInAnonymously() async {
    final userCred = await _firebaseAuth.signInAnonymously();
    return userCred.user;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

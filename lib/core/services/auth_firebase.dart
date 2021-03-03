import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  User get currentUser;
  Future<User> signInAnonymously();
  Future<void> signOut();
}

class AuthFirebase implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  User get currentUser => _firebaseAuth.currentUser;

  Future<User> signInAnonymously() async {
    final userCred = await _firebaseAuth.signInAnonymously();
    return userCred.user;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

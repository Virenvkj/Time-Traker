import 'package:Time_Tracker/core/constants/app_constants.dart';
import 'package:Time_Tracker/ui/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  User get currentUser;
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
  Future<User> signInAnonymously();
  Stream<User> authStateChanges();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  User get currentUser => _firebaseAuth.currentUser;

  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  //Google Sign in

  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    try {
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        if (googleAuth.idToken != null) {
          final userCredential = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken,
            ),
          );
          if (userCredential.user != null) {
            print('User Id : ${userCredential.user.uid}');
            return userCredential.user;
            // Navigator.of(context).pushReplacement(
            //   new MaterialPageRoute(
            //     builder: (context) => HomeScreen(
            //       user: userCredential.user,
            //     ),
            //   ),
            // );
          } else {
            throw FirebaseAuthException(
                message: 'Authenticaion Failed', code: 'AUTHENTICATION FAILED');
          }
        } else {
          throw FirebaseAuthException(
              message: 'Missing Google Id Token',
              code: 'MISSING GOOGLE ID TOKEN');
        }
      } else {
        throw FirebaseAuthException(
            message: 'Authentication Aborted by user',
            code: 'AUTHENTICATION ABORTED BY USER');
      }
    } on FirebaseAuthException catch (error) {
      print(error.message);
      AppConstants.showFailedToast(message: error.message.toString());
    }
  }

  // Facebook Sign in
  Future<User> signInWithFacebook() async {
    final fb = FacebookLogin();
    final response = await fb.logIn(
      permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ],
    );
    try {
      if (response.status == FacebookLoginStatus.success) {
        final accessToken = response.accessToken;
        final userCredential = await _firebaseAuth.signInWithCredential(
          FacebookAuthProvider.credential(accessToken.token),
        );

        if (userCredential.user != null) {
          return userCredential.user;
          //   Navigator.of(context).pushReplacement(
          //     new MaterialPageRoute(
          //       builder: (context) => HomeScreen(
          //         user: userCredential.user,
          //       ),
          //     ),
          //   );
        }
      } else {
        throw FirebaseAuthException(
            message: 'Facebook Authentication Failed',
            code: 'FACEBOOK AUTH FAILED');
      }
    } on FirebaseAuthException catch (error) {
      print(error.message);
      AppConstants.showFailedToast(message: error.message.toString());
    }
  }

  //Anonymous Sign In
  Future<User> signInAnonymously() async {
    try {
      final userCredentials = await _firebaseAuth.signInAnonymously();
      if (userCredentials.user.uid != null) {
        print('User Id : ${userCredentials.user.uid}');
        return userCredentials.user;
        // Navigator.of(context).pushReplacement(
        //   new MaterialPageRoute(
        //     builder: (context) => HomeScreen(
        //       user: userCredentials.user,
        //     ),
        //   ),
        // );
      }
    } on FirebaseAuthException catch (error) {
      AppConstants.showFailedToast(message: error.message.toString());
    }
  }
}

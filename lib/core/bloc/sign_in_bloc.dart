import 'dart:async';
import 'package:Time_Tracker/core/services/auth_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SignInBloc {
  final AuthBase auth;
  SignInBloc({this.auth});

  final StreamController isLoadingController = StreamController<bool>();
  Stream<bool> get isLoadingStream => isLoadingController.stream;

  void dispose() {
    isLoadingController.close();
  }

  void setIsLoading(bool isLoading) => isLoadingController.add(isLoading);

  Future<User> signIn(Future<User> Function() signInMethod) async {
    try {
      setIsLoading(true);
      return await signInMethod();
    } catch (error) {
      setIsLoading(false);
      rethrow;
    }
  }

  Future<User> signInWithGoogle() async => await signIn(auth.signInWithGoogle);
  Future<User> signInWithFacebook() async =>
      await signIn(auth.signInWithFacebook);
  Future<User> signInAnonymously() async =>
      await signIn(auth.signInAnonymously);
}

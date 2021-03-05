import 'package:Time_Tracker/core/services/auth_firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthProviderNew extends InheritedWidget {
  final AuthBase auth;
  final Widget child;
  AuthProviderNew({@required this.auth, @required this.child});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return null;
  }

  static AuthBase of(BuildContext context) {
    AuthProviderNew provider =
        context.dependOnInheritedWidgetOfExactType<AuthProviderNew>();
    return provider.auth;
  }
}

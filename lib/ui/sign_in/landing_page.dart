import 'package:Time_Tracker/ui/home/home_screen.dart';
import 'package:Time_Tracker/ui/sign_in/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool newUser;

  //Following method holds the logic for checking the user is a new user or an existing user.

  void checkNewUser() {
    User _user = FirebaseAuth.instance.currentUser;
    print('User Id : ${_user.uid}');
    if (_user == null) {
      newUser = true;
    } else {
      newUser = false;
    }
  }

  @override
  void initState() {
    checkNewUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return newUser ? SignInPage() : HomeScreen(); //Displaying screens on the basis of user existing or new.
  }
}

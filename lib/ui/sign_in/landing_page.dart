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
  User currentUser;

  //Following method holds the logic for checking the user is a new user or an existing user.

  void checkNewUser(User user) {
    if (user == null) {
      newUser = true;
    } else {
      print('User Id : ${user.uid}');
      newUser = false;
    }
  }

  @override
  void initState() {
    currentUser = FirebaseAuth.instance.currentUser;
    checkNewUser(currentUser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return newUser
        ? SignInPage.create(context)
        : HomeScreen(
            user: currentUser,
          ); //Displaying screens on the basis of user existing or new.
  }
}

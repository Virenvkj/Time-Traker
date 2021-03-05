import 'dart:io';

import 'package:Time_Tracker/core/constants/app_colors.dart';
import 'package:Time_Tracker/core/constants/app_strings.dart';
import 'package:Time_Tracker/core/constants/app_styles.dart';
import 'package:Time_Tracker/ui/sign_in/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatelessWidget {
  final User user;
  HomeScreen({@required this.user});

  //Following method holds the logic for user logout.

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    final googleSignIn = GoogleSignIn();
    final fb = FacebookLogin();
    await fb.logOut();
    await googleSignIn.signOut();
    await Navigator.of(context).pushReplacement(
      new MaterialPageRoute(
        builder: (context) => SignInPage.create(context),
      ),
    );
  }

  confirmLogOut(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(AppStrings.logout),
            content: Text(AppStrings.logOutMsg),
            actions: [
              FlatButton(
                child: Text(AppStrings.cancel),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(AppStrings.logout),
                onPressed: () => logout(context),
              ),
            ],
          );
        },
      );
    } else if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(AppStrings.logout),
            content: Text(AppStrings.logOutMsg),
            actions: [
              FlatButton(
                child: Text(AppStrings.cancel),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(AppStrings.logout),
                onPressed: () => logout(context),
              ),
            ],
          );
        },
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.homePage,
          style: AppStyles.whiteBold22(),
        ),
        centerTitle: true,
        elevation: 2.0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () =>
                confirmLogOut(context), //calling out logout method.
          ),
        ],
      ),
      backgroundColor: AppColors.defaultWhite,
    );
  }
}

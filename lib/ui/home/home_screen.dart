import 'package:Time_Tracker/core/constants/app_colors.dart';
import 'package:Time_Tracker/core/constants/app_strings.dart';
import 'package:Time_Tracker/core/constants/app_styles.dart';
import 'package:Time_Tracker/ui/sign_in/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  
  //Following method holds the logic for user logout. 

  Future<void> logout(BuildContext context) async {
    // await FirebaseAuth.instance.currentUser.delete();
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute(
        builder: (context) => SignInPage(),
      ),
    );
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
            onPressed: () => logout(context),  //calling out logout method.
          ),
        ],
      ),
      backgroundColor: AppColors.defaultWhite,
    );
  }
}

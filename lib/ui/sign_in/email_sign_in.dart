import 'package:Time_Tracker/common_widgets/email_sign_in_form.dart';
import 'package:Time_Tracker/core/bloc/sign_in_bloc.dart';
import 'package:Time_Tracker/core/constants/app_colors.dart';
import 'package:Time_Tracker/core/constants/app_strings.dart';
import 'package:Time_Tracker/core/constants/app_styles.dart';
import 'package:Time_Tracker/ui/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailSignIn extends StatefulWidget {
  @override
  _EmailSignInState createState() => _EmailSignInState();
}

class _EmailSignInState extends State<EmailSignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2.0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.of(context).pushReplacement(
                  new MaterialPageRoute(
                    builder: (context) => SignInPage.create(context),
                  ),
                );
              },
            ),
            Text(
              AppStrings.signIn,
              style: AppStyles.whiteBold22(),
            ),
            Opacity(
              opacity: 0.0,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: null,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.dullWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            color: AppColors.defaultWhite,
            child: EmailSignInForm(),
          ),
        ),
      ),
    );
  }
}

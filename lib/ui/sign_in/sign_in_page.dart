import 'package:Time_Tracker/common_widgets/sign_in_button.dart';
import 'package:Time_Tracker/core/constants/app_colors.dart';
import 'package:Time_Tracker/core/constants/app_constants.dart';
import 'package:Time_Tracker/core/constants/app_strings.dart';
import 'package:Time_Tracker/core/constants/app_styles.dart';
import 'package:Time_Tracker/core/constants/size_config.dart';
import 'package:Time_Tracker/ui/home/home_screen.dart';
import 'package:Time_Tracker/ui/sign_in/email_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

final _firebaseAuth = FirebaseAuth.instance;

//Following method holds the logic for anonymous sign In

Future<void> signInAnonymously(BuildContext context) async {
  //Anonymous Sign in
  final userCredentials = await _firebaseAuth.signInAnonymously();
  if (userCredentials.user.uid != null) {
    print('User Id : ${userCredentials.user.uid}');
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute(
        builder: (context) => HomeScreen(
          user: userCredentials.user,
        ),
      ),
    );
  }
}

//Following method holds the logic for Sign In with Google

signInWithGoogle(BuildContext context) async {
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
          Navigator.of(context).pushReplacement(
            new MaterialPageRoute(
              builder: (context) => HomeScreen(
                user: userCredential.user,
              ),
            ),
          );
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
  } catch (error) {
    print(error);
  }
}

//Following method holds the logic for Sign In with Facebook

Future<void> signInWithFacebook(BuildContext context) async {
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
      Navigator.of(context).pushReplacement(
        new MaterialPageRoute(
          builder: (context) => HomeScreen(
            user: userCredential.user,
          ),
        ),
      );
    } else {
      throw FirebaseAuthException(
          message: 'Facebook Authentication Failed',
          code: 'FACEBOOK AUTH FAILED');
    }
  } catch (error) {
    print(error);
  }
}

//Following method holds the logic for SIgn in with Email

void signInWithEmail(BuildContext context) {
  Navigator.of(context).pushReplacement(
    new MaterialPageRoute(
      builder: (context) => EmailSignIn(),
    ),
  );
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dullWhite,
      appBar: AppBar(
        title: Text(
          AppStrings.timeTracker,
          textAlign: TextAlign.center,
          style: AppStyles.whiteBold22(),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: Container(
        padding: SizeConfig.paddingAll20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: getChildren(context), //calling widget list
        ),
      ),
    );
  }
}

//Following method returns a list of widgets to be displayed.

List<Widget> getChildren(BuildContext context) {
  return [
    Text(
      AppStrings.signIn,
      style: AppStyles.blackBold26(),
    ),
    AppConstants.sizer(height: 0.04, width: 0, context: context),
    SignInButton(
      textColor: AppColors.defaultBlack,
      buttonColor: AppColors.defaultWhite,
      icon: Image.asset('lib/core/assets/google_logo.png'),
      buttonText: AppStrings.signInWithGoogle,
      onPress: () => signInWithGoogle(context),
    ),
    AppConstants.sizer(height: 0.02, width: 0, context: context),
    SignInButton(
      textColor: AppColors.defaultWhite,
      buttonColor: AppColors.facebookBlue,
      icon: Image.asset('lib/core/assets/facebook_logo.png'),
      buttonText: AppStrings.signInWithFacebook,
      onPress: () => signInWithFacebook(context),
    ),
    AppConstants.sizer(height: 0.02, width: 0, context: context),
    SignInButton(
      textColor: AppColors.defaultWhite,
      buttonColor: AppColors.defaultGreen,
      icon: Container(),
      buttonText: AppStrings.signInWithEmail,
      onPress: () => signInWithEmail(context),
    ),
    AppConstants.sizer(height: 0.01, width: 0, context: context),
    Text(
      AppStrings.or,
    ),
    AppConstants.sizer(height: 0.01, width: 0, context: context),
    SignInButton(
      textColor: AppColors.defaultBlack,
      buttonColor: AppColors.lightYellow,
      icon: Container(),
      buttonText: AppStrings.goAnonymous,
      onPress: () => signInAnonymously(context),
    ),
  ];
}

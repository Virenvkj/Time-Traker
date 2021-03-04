import 'package:Time_Tracker/common_widgets/sign_in_button.dart';
import 'package:Time_Tracker/core/constants/app_colors.dart';
import 'package:Time_Tracker/core/constants/app_constants.dart';
import 'package:Time_Tracker/core/constants/app_strings.dart';
import 'package:Time_Tracker/core/constants/app_styles.dart';
import 'package:Time_Tracker/core/constants/size_config.dart';
import 'package:Time_Tracker/ui/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';

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

// signInWithGoogle(BuildContext context) async{
//   final googleSignIn =
// }

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
          mainAxisSize: MainAxisSize.max,
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
      onPress: () {},
    ),
    AppConstants.sizer(height: 0.02, width: 0, context: context),
    SignInButton(
      textColor: AppColors.defaultWhite,
      buttonColor: AppColors.facebookBlue,
      icon: Image.asset('lib/core/assets/facebook_logo.png'),
      buttonText: AppStrings.signInWithFacebook,
      onPress: () {},
    ),
    AppConstants.sizer(height: 0.02, width: 0, context: context),
    SignInButton(
      textColor: AppColors.defaultWhite,
      buttonColor: AppColors.defaultGreen,
      icon: Container(),
      buttonText: AppStrings.signInWithEmail,
      onPress: () {},
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

import 'package:Time_Tracker/common_widgets/sign_in_button.dart';
import 'package:Time_Tracker/core/bloc/sign_in_bloc.dart';
import 'package:Time_Tracker/core/constants/app_colors.dart';
import 'package:Time_Tracker/core/constants/app_constants.dart';
import 'package:Time_Tracker/core/constants/app_strings.dart';
import 'package:Time_Tracker/core/constants/app_styles.dart';
import 'package:Time_Tracker/core/constants/size_config.dart';
import 'package:Time_Tracker/core/services/auth_firebase.dart';
import 'package:Time_Tracker/ui/home/home_screen.dart';
import 'package:Time_Tracker/ui/sign_in/email_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<SignInBloc>(
      dispose: (_, bloc) => bloc.dispose(),
      create: (_) => SignInBloc(auth: auth),
      child: SignInPage(),
    );
  }

  //Following method holds the logic for SIgn in with Email

  void signInWithEmail(BuildContext context) {
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute(
        builder: (context) => EmailSignIn(),
      ),
    );
  }

  //Following method holds the logic for anonymous sign In

  Future<void> signInAnonymously(BuildContext context) async {
    final bloc = Provider.of<SignInBloc>(context, listen: false);
    bloc.setIsLoading(true);
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      User _user = await auth.signInAnonymously();
      if (_user != null) {
        Navigator.of(context).pushReplacement(
          new MaterialPageRoute(
            builder: (context) => HomeScreen(
              user: _user,
            ),
          ),
        );
      } else {
        AppConstants.showFailedToast(message: AppStrings.failed);
      }
    } catch (e) {
      print(e);
    } finally {
      bloc.setIsLoading(false);
    }
  }

  //Following method holds the logic for Sign In with Google

  signInWithGoogle(BuildContext context) async {
    final bloc = Provider.of<SignInBloc>(context, listen: false);
    bloc.setIsLoading(true);
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      User _user = await auth.signInWithGoogle();
      if (_user != null) {
        Navigator.of(context).pushReplacement(
          new MaterialPageRoute(
            builder: (context) => HomeScreen(
              user: _user,
            ),
          ),
        );
      } else {
        AppConstants.showFailedToast(message: AppStrings.failed);
      }
    } catch (e) {} finally {
      bloc.setIsLoading(false);
    }
  }

  //Following method holds the logic for Sign In with Facebook

  Future<void> signInWithFacebook(BuildContext context) async {
    final bloc = Provider.of<SignInBloc>(context, listen: false);
    try {
      User _user = await bloc.signInWithFacebook();
      if (_user != null) {
        Navigator.of(context).pushReplacement(
          new MaterialPageRoute(
            builder: (context) => HomeScreen(
              user: _user,
            ),
          ),
        );
      } else {
        AppConstants.showFailedToast(message: AppStrings.failed);
      }
    } catch (e) {
      print(e);
    }
  }

  //Following method returns a list of widgets to be displayed.

  List<Widget> getChildren(BuildContext context, bool isLoading) {
    final bloc = Provider.of<SignInBloc>(context, listen: false);
    return [
      !isLoading
          ? Text(
              AppStrings.signIn,
              style: AppStyles.blackBold26(),
            )
          : AppConstants.circularProgressIndicator(),
      AppConstants.sizer(height: 0.04, width: 0, context: context),
      SignInButton(
        enabled: !isLoading ? true : false,
        textColor: AppColors.defaultBlack,
        buttonColor: AppColors.defaultWhite,
        icon: Image.asset('lib/core/assets/google_logo.png'),
        buttonText: AppStrings.signInWithGoogle,
        onPress: () => signInWithGoogle(context),
      ),
      AppConstants.sizer(height: 0.02, width: 0, context: context),
      SignInButton(
        enabled: !isLoading ? true : false,
        textColor: AppColors.defaultWhite,
        buttonColor: AppColors.facebookBlue,
        icon: Image.asset('lib/core/assets/facebook_logo.png'),
        buttonText: AppStrings.signInWithFacebook,
        onPress: () => signInWithFacebook(context),
      ),
      AppConstants.sizer(height: 0.02, width: 0, context: context),
      SignInButton(
        enabled: !isLoading ? true : false,
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
        enabled: !isLoading ? true : false,
        textColor: AppColors.defaultBlack,
        buttonColor: AppColors.lightYellow,
        icon: Container(),
        buttonText: AppStrings.goAnonymous,
        onPress: () => signInAnonymously(context),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SignInBloc>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.dullWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppStrings.timeTracker,
          textAlign: TextAlign.center,
          style: AppStyles.whiteBold22(),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: StreamBuilder<bool>(
          initialData: false,
          stream: bloc.isLoadingStream,
          builder: (context, snapshot) {
            return Container(
              padding: SizeConfig.paddingAll20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:
                    getChildren(context, snapshot.data), //calling widget list
              ),
            );
          }),
    );
  }
}

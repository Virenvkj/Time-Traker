import 'package:Time_Tracker/core/constants/app_colors.dart';
import 'package:Time_Tracker/core/constants/app_constants.dart';
import 'package:Time_Tracker/core/constants/app_strings.dart';
import 'package:Time_Tracker/core/constants/app_styles.dart';
import 'package:Time_Tracker/ui/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailSignInForm extends StatefulWidget {
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  final _firebaseAuth = FirebaseAuth.instance;
  bool signInEnable = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool autoValidation = false;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> signInWithEmailandPassword(
      {String email, String password}) async {
    try {
      final emailLogin = await _firebaseAuth.signInWithCredential(
        EmailAuthProvider.credential(
          email: email,
          password: password,
        ),
      );
      if (emailLogin != null) {
        Navigator.of(context).pushReplacement(
          new MaterialPageRoute(
            builder: (context) => HomeScreen(
              user: emailLogin.user,
            ),
          ),
        );
      }
    } catch (error) {
      AppConstants.showFailedToast(message: error.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> createUserWithEmailandPassword(
      {String email, String password}) async {
    try {
      final emailRegister = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (emailRegister != null) {
        print(emailRegister.user);
        print('Successfully Registered');
        emailController.clear();
        passwordController.clear();
        setState(() {
          signInEnable = true;
        });
      }
    } catch (error) {
      AppConstants.showFailedToast(message: error.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void onChangeLoginType() {
    setState(
      () {
        signInEnable = !signInEnable;
        emailController.clear();
        passwordController.clear();
      },
    );
  }

  void onSubmit() {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState.validate()) {
      print(
          'Email : ${emailController.text}\n Password : ${passwordController.text}');
      signInEnable
          ? signInWithEmailandPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            )
          : createUserWithEmailandPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );
    } else {
      setState(
        () {
          autoValidation = true;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              autovalidate: autoValidation,
              validator: (value) {
                if (value.isEmpty) {
                  return AppStrings.emailErrorText;
                }
                return null;
              },
              onChanged: (val) {
                setState(() {});
              },
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(passwordFocusNode);
              },
              focusNode: emailFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              controller: emailController,
              decoration: InputDecoration(
                enabled: isLoading ? false : true,
                hintText: AppStrings.emailHintText,
                labelText: AppStrings.email,
              ),
            ),
            AppConstants.sizer(context: context, height: 0.02, width: 0),
            TextFormField(
              autovalidate: autoValidation,
              validator: (value) {
                if (value.isEmpty) {
                  return AppStrings.passwordErrorText;
                } else if (value.length < 6) {
                  return AppStrings.passwordLengthErrorText;
                }
                return null;
              },
              onChanged: (val) {
                setState(() {});
              },
              focusNode: passwordFocusNode,
              textInputAction: TextInputAction.done,
              autocorrect: false,
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                enabled: isLoading ? false : true,
                labelText: AppStrings.password,
              ),
            ),
            AppConstants.sizer(context: context, height: 0.02, width: 0),
            !isLoading
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width,
                    child: FlatButton(
                      onPressed: (emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty)
                          ? onSubmit
                          : null,
                      disabledColor: AppColors.defaultGrey,
                      color: AppColors.defaultIndigo,
                      child: Text(
                        signInEnable ? AppStrings.signIn : AppStrings.register,
                        style: AppStyles.whiteBold22(),
                      ),
                    ),
                  )
                : AppConstants.circularProgressIndicator(),
            AppConstants.sizer(context: context, height: 0.02, width: 0),
            InkWell(
              onTap: isLoading ? null : onChangeLoginType,
              child: Text(
                signInEnable
                    ? AppStrings.needAnAccReg
                    : AppStrings.alreadyHaveAnAccount,
                style: AppStyles.blackNormal16(),
              ),
            ),
            AppConstants.sizer(context: context, height: 0.02, width: 0),
          ],
        ),
      ),
    );
  }
}

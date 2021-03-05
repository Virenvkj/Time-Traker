import 'package:Time_Tracker/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'app_colors.dart';

class AppConstants {
  static Widget sizer({double height, double width, BuildContext context}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * height,
      width: MediaQuery.of(context).size.width * width,
    );
  }

  static Widget circularProgressIndicator() {
    return CircularProgressIndicator(
      backgroundColor: AppColors.defaultBlue,
    );
  }

  static showSuccessToast() {
    return Fluttertoast.showToast(
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 3,
      gravity: ToastGravity.CENTER,
      msg: AppStrings.success,
      backgroundColor: AppColors.defaultGreen,
      textColor: AppColors.defaultWhite,
    );
  }

  static showFailedToast({String message}) {
    return Fluttertoast.showToast(
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 3,
      gravity: ToastGravity.CENTER,
      msg: message,
      backgroundColor: AppColors.defaultRed,
      textColor: AppColors.defaultWhite,
    );
  }
}

import 'package:Time_Tracker/core/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';

class AppStyles {
  static TextStyle blackBold26() => TextStyle(
        color: AppColors.defaultBlack,
        fontSize: 26,
        fontWeight: FontWeight.bold,
      );
  static TextStyle whiteBold22() => TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: AppColors.defaultWhite,
      );
  static TextStyle indigoBold18() => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.defaultIndigo,
      );
  static TextStyle blackNormal16() => TextStyle(
        color: AppColors.defaultBlack,
        fontSize: 16,
      );
}

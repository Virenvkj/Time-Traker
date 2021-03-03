import 'package:flutter/material.dart';

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
}

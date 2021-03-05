import 'package:Time_Tracker/core/constants/size_config.dart';
import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  @required
  final bool enabled;
  @required
  final String buttonText;
  @required
  final Widget icon;
  @required
  final Color buttonColor;
  @required
  final Color textColor;
  @required
  final Function onPress;
  SignInButton(
      {this.enabled,
      this.buttonText,
      this.icon,
      this.buttonColor,
      this.textColor,
      this.onPress})
      : assert(buttonText != null, buttonColor != null);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onPress : null,
      child: Container(
        padding: SizeConfig.paddingH20V10,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.09,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon,
            Center(
                child: Text(
              buttonText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: textColor, fontWeight: FontWeight.w500, fontSize: 20),
            )),
            Opacity(
              opacity: 0.0,
              child: icon,
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

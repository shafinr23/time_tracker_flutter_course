import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/custome_raised_button.dart';

class SingInButton extends CustomeRaisedButton {
  SingInButton({
    String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
    double height,
  }) : super(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 15.0,
              ),
            ),
            color: color,
            onPressed: onPressed,
            height: height);
}

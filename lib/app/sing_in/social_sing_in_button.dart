import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/custome_raised_button.dart';

class SocialSingInButton extends CustomeRaisedButton {
  SocialSingInButton({
    @required String assetName,
    String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
    double height,
  }) : super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset(assetName),
              Text(
                text,
                style: TextStyle(color: textColor, fontSize: 15.0),
              ),
              Opacity(opacity: 0.0, child: Image.asset(assetName)),
            ],
          ),
          color: color,
          onPressed: onPressed,
          height: height,
        );
}

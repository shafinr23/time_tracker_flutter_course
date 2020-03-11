import 'package:flutter/material.dart';

class CustomeRaisedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadias;
  final VoidCallback onPressed;
  final double height;

  CustomeRaisedButton({
    this.color,
    this.child,
    this.borderRadias: 2.0,
    this.onPressed,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        onPressed: onPressed,
        child: child,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadias),
          ),
        ),
      ),
    );
  }
}

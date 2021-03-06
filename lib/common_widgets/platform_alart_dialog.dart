import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/paltform_widget.dart';

class PlatformAlartDialog extends PlatformWidgets {
  final String title;
  final String content;
  final String defaultActionText;
  final String cancelActionButton;

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
            context: context,
            builder: (context) => this,
          )
        : await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (context) => this,
          );
  }

  PlatformAlartDialog({
    @required this.title,
    @required this.content,
    this.cancelActionButton,
    @required this.defaultActionText,
  })  : assert(title != null),
        assert(content != null),
        assert(defaultActionText != null);

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    final action = <Widget>[];
    if (cancelActionButton != null) {
      action.add(
        PlatformAlertDialogAction(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelActionButton),
        ),
      );
    }
    action.add(
      PlatformAlertDialogAction(
        onPressed: () => Navigator.of(context).pop(true),
        child: Text(defaultActionText),
      ),
    );
    return action;
  }
}

class PlatformAlertDialogAction extends PlatformWidgets {
  final Widget child;
  final VoidCallback onPressed;

  PlatformAlertDialogAction({
    this.child,
    this.onPressed,
  });

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    // TODO: implement buildCupertinoWidget
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    // TODO: implement buildMaterialWidget
    return FlatButton(
      child: child,
      onPressed: onPressed,
      color: Colors.indigo,
    );
  }
}

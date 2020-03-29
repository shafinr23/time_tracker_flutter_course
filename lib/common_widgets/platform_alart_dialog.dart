import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/paltform_widget.dart';

class PlatformAlartDialog extends PlatformWidgets {
  final String title;
  final String content;
  final String defaultActionText;

  PlatformAlartDialog({
    @required this.title,
    @required this.content,
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
    return [
      PlatformAlertDialogAction(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(defaultActionText),
      ),
    ];
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
    );
  }
}

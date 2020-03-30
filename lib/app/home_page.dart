import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_alart_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth_provider.dart';

class HomePage extends StatelessWidget {
  Future<void> _singOut(BuildContext context) async {
    try {
      final auth = AuthProvider.of(context);
      await auth.singOut();
      //onSignOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSingout(BuildContext context) async {
    final didRequestSingout = await PlatformAlartDialog(
            title: 'Logout',
            content: 'are you sure you logout ',
            defaultActionText: 'Logout',
            cancelActionButton: 'cancle')
        .show(context);
    if (didRequestSingout == true) {
      _singOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Log Out',
              style: TextStyle(fontSize: 17.0, color: Colors.white),
            ),
            onPressed: () => _confirmSingout(context),
          )
        ],
      ),
    );
  }
}

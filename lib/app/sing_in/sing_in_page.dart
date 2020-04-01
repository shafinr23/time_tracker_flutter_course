import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sing_in/sing_in_bloc.dart';
import 'package:time_tracker_flutter_course/app/sing_in/sing_in_button.dart';
import 'package:time_tracker_flutter_course/app/sing_in/social_sing_in_button.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

import 'email_sing_in_page.dart';

class SingInPage extends StatefulWidget {
  static Widget create(BuildContext context) {
    return Provider<SingInBloc>(
      create: (_) => SingInBloc(),
      child: SingInPage(),
    );
  }

  @override
  _SingInPageState createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  bool _isLoading = false;

  void _showSingInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'SING IN FAILED',
      exception: exception,
    ).show(context);
  }

  Future<void> _singInAnonymously(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.singInAnonymosly();
      //print('${authResult.user.uid}');
      // onSingIn(user);
    } on PlatformException catch (e) {
      _showSingInError(context, e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _singInWithGoogle(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.singInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'Error_abrotted_by_user') {
        _showSingInError(context, e);
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _singInEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSingInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SingInBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('time tracker'),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: StreamBuilder<Object>(
          stream: null,
          initialData: false,
          builder: (context, snapshot) {
            return _buildContent(context, snapshot.data);
          }),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context, bool isLoading) {
    return Padding(
      padding: EdgeInsets.all(15.00),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildHeader(),
          SizedBox(
            height: 48.0,
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSingInButton(
            assetName: 'images/google-logo.png',
            text: 'Sing In With Google',
            textColor: Colors.black87,
            color: Colors.white,
            onPressed: _isLoading ? null : () => _singInWithGoogle(context),
            height: 50.0,
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSingInButton(
            assetName: 'images/facebook-logo.png',
            text: 'Sing In With Facebook',
            textColor: Colors.white,
            color: Color(0XFF334D92),
            onPressed: () {},
            height: 50.0,
          ),
          SizedBox(
            height: 8.0,
          ),
          SingInButton(
            text: 'Sing In With email',
            textColor: Colors.white,
            color: Colors.teal[700],
            onPressed: () => _singInEmail(context),
            height: 50.0,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'or',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          SizedBox(
            height: 8.0,
          ),
          SingInButton(
            text: 'Go Anonymous',
            textColor: Colors.black87,
            color: Colors.lime[300],
            onPressed: _isLoading ? null : () => _singInAnonymously(context),
            height: 50.0,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'Sing In',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/sing_in/sing_in_button.dart';
import 'package:time_tracker_flutter_course/app/sing_in/social_sing_in_button.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

import 'email_sing_in_page.dart';

class SingInPage extends StatelessWidget {
  SingInPage({@required this.auth});
  //final Function(User) onSingIn;
  final AuthBase auth;
  Future<void> _singInAnonymously() async {
    try {
      await auth.singInAnonymosly();
      //print('${authResult.user.uid}');
      // onSingIn(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _singInWithGoogle() async {
    try {
      await auth.singInWithGoogle();
    } catch (e) {
      print(e.toString());
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
    return Scaffold(
      appBar: AppBar(
        title: Text('time tracker'),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.00),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Sing In',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
            ),
          ),
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
            onPressed: _singInWithGoogle,
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
            onPressed: _singInAnonymously,
            height: 50.0,
          ),
        ],
      ),
    );
  }
}

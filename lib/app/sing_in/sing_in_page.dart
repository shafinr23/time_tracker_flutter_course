import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sing_in/sing_in_bloc.dart';
import 'package:time_tracker_flutter_course/app/sing_in/sing_in_button.dart';
import 'package:time_tracker_flutter_course/app/sing_in/social_sing_in_button.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

import 'email_sing_in_page.dart';

class SingInPage extends StatelessWidget {
  final SingInBloc bloc;

  const SingInPage({Key key, this.bloc}) : super(key: key);
  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return Provider<SingInBloc>(
      create: (_) => SingInBloc(auth: auth),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<SingInBloc>(
          builder: (
        context,
        bloc,
        _,
      ) =>
              SingInPage(
                bloc: bloc,
              )),
    );
  }

  void _showSingInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'SING IN FAILED',
      exception: exception,
    ).show(context);
  }

  Future<void> _singInAnonymously(BuildContext context) async {
    try {
      await bloc.singInAnonymosly();
      //print('${authResult.user.uid}');
      // onSingIn(user);
    } on PlatformException catch (e) {
      _showSingInError(context, e);
    }
  }

  Future<void> _singInWithGoogle(BuildContext context) async {
    try {
      await bloc.singInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'Error_abrotted_by_user') {
        _showSingInError(context, e);
      }
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
      body: StreamBuilder<bool>(
          stream: bloc.isLoadingStream,
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
          _buildHeader(isLoading),
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
            onPressed: isLoading ? null : () => _singInWithGoogle(context),
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
            onPressed: isLoading ? null : () => _singInAnonymously(context),
            height: 50.0,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isLoading) {
    if (isLoading) {
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

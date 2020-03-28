import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

import 'email_sing_in_form.dart';

class EmailSingInPage extends StatelessWidget {
  EmailSingInPage({@required this.auth});
  final AuthBase auth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('time tracker'),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: EmailSingInForm(
              auth: auth,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}

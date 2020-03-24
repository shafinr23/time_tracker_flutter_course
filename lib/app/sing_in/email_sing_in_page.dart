import 'package:flutter/material.dart';

import 'email_sing_in_form.dart';

class EmailSingInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('time tracker'),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: EmailSingInForm(),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}

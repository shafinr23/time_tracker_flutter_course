import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/form_submit_button.dart';

enum EmailSingInType { singin, register }

class EmailSingInForm extends StatefulWidget {
  @override
  _EmailSingInFormState createState() => _EmailSingInFormState();
}

class _EmailSingInFormState extends State<EmailSingInForm> {
  final TextEditingController _emailController = TextEditingController();
  // String email;
  final TextEditingController _passController = TextEditingController();

  EmailSingInType _formtype = EmailSingInType.singin;
  void _submit() {
    print('email ${_emailController.text} and pass: ${_passController.text}');
  }

  void _toggolForm() {
    setState(() {
      _formtype = _formtype == EmailSingInType.singin
          ? EmailSingInType.register
          : EmailSingInType.singin;
    });
    _emailController.clear();
    _passController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText =
        _formtype == EmailSingInType.singin ? 'sing in' : 'create an account ';

    final secenderText = _formtype == EmailSingInType.register
        ? 'meed an account ? register '
        : 'have a acount ? sing in';
    return [
      TextField(
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'Test@email.com',
        ),
        controller: _emailController,
      ),
      TextField(
        decoration: InputDecoration(
          labelText: 'passWord',
        ),
        obscureText: true,
        controller: _passController,
      ),
      FormSubmitButton(
        onPressed: _submit,
        text: primaryText,
      ),
      FlatButton(
        onPressed: _toggolForm,
        child: Text(secenderText),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/sing_in/validator.dart';
import 'package:time_tracker_flutter_course/common_widgets/form_submit_button.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

enum EmailSingInType { singin, register }

class EmailSingInForm extends StatefulWidget with EmailAndPasswordValidator {
  EmailSingInForm({this.auth});
  final AuthBase auth;
  @override
  _EmailSingInFormState createState() => _EmailSingInFormState();
}

class _EmailSingInFormState extends State<EmailSingInForm> {
  final TextEditingController _emailController = TextEditingController();
  // String email;
  final TextEditingController _passController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _pass => _passController.text;
  EmailSingInType _formtype = EmailSingInType.singin;
  void _emailEdottingCompleate() {
    FocusScope.of(context).requestFocus(_passFocusNode);
  }

  void _submit() async {
    try {
      if (_formtype == EmailSingInType.singin) {
        await widget.auth.singInWithEmailpass(_email, _pass);
      } else {
        await widget.auth.regInWithEmailpass(_email, _pass);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
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
    bool submitEnable = widget.emailValidator.isvalid(_email) &&
        widget.passValidator.isvalid(_pass);
    return [
      _buildEmailTextField(),
      _buildPassTextField(),
      FormSubmitButton(
        onPressed: submitEnable ? _submit : null,
        text: primaryText,
      ),
      FlatButton(
        onPressed: _toggolForm,
        child: Text(secenderText),
      )
    ];
  }

  TextField _buildPassTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'passWord',
      ),
      obscureText: true,
      controller: _passController,
      textInputAction: TextInputAction.done,
      focusNode: _passFocusNode,
      onChanged: (pass) {
        _updateState();
      },
    );
  }

  TextField _buildEmailTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Test@email.com',
      ),
      controller: _emailController,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      focusNode: _emailFocusNode,
      onEditingComplete: _emailEdottingCompleate,
      onChanged: (email) {
        _updateState;
      },
    );
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

  void _updateState() {
    //  print('email is : $_email , pass is : $_pass');
    setState(() {});
  }
}

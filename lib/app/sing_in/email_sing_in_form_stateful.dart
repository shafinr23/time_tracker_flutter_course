import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sing_in/validator.dart';
import 'package:time_tracker_flutter_course/common_widgets/form_submit_button.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

enum EmailSingInType { singin, register }

class EmailSingInFormStateful extends StatefulWidget
    with EmailAndPasswordValidator {
  @override
  _EmailSingInFormStatefulState createState() =>
      _EmailSingInFormStatefulState();
}

class _EmailSingInFormStatefulState extends State<EmailSingInFormStateful> {
  final TextEditingController _emailController = TextEditingController();
  // String email;
  final TextEditingController _passController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _pass => _passController.text;
  EmailSingInType _formtype = EmailSingInType.singin;
  bool _submitted = false;
  bool _isLoading = false;
  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    _passController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  void _emailEdottingCompleate() {
    final newFocus = widget.emailValidator.isvalid(_email)
        ? _passFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      if (_formtype == EmailSingInType.singin) {
        await auth.singInWithEmailpass(_email, _pass);
      } else {
        await auth.regInWithEmailpass(_email, _pass);
      }
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      //print(e.toString());
      PlatformExceptionAlertDialog(
        title: 'Sing in Failed ',
        exception: e,
      ).show(context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggolForm() {
    setState(() {
      _submitted = false;
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
        widget.passValidator.isvalid(_pass) &&
        !_isLoading;
    return [
      _buildEmailTextField(),
      _buildPassTextField(),
      FormSubmitButton(
        onPressed: submitEnable ? _submit : null,
        text: primaryText,
      ),
      FlatButton(
        onPressed: !_isLoading ? _toggolForm : null,
        child: Text(secenderText),
      )
    ];
  }

  TextField _buildPassTextField() {
    bool showErrorText = _submitted && !widget.passValidator.isvalid(_pass);
    return TextField(
      decoration: InputDecoration(
        enabled: _isLoading == false,
        labelText: 'passWord',
        errorText: showErrorText ? widget.invalidePassError : null,
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
    bool showErrorText = _submitted && !widget.emailValidator.isvalid(_email);
    return TextField(
      decoration: InputDecoration(
        enabled: _isLoading == false,
        labelText: 'Email',
        hintText: 'Test@email.com',
        errorText: showErrorText ? widget.invalideEmailError : null,
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

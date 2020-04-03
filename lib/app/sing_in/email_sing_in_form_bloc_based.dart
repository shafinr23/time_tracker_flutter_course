import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sing_in/emailSingInModel.dart';
import 'package:time_tracker_flutter_course/app/sing_in/email_sing_in_bloc.dart';
import 'package:time_tracker_flutter_course/app/sing_in/validator.dart';
import 'package:time_tracker_flutter_course/common_widgets/form_submit_button.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class EmailSingInFormBlocBased extends StatefulWidget
    with EmailAndPasswordValidator {
  EmailSingInFormBlocBased({@required this.bloc});
  final EmailSingInBloc bloc;
  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return Provider<EmailSingInBloc>(
      create: (context) => EmailSingInBloc(auth: auth),
      child: Consumer<EmailSingInBloc>(
        builder: (context, bloc, _) => EmailSingInFormBlocBased(
          bloc: bloc,
        ),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  _EmailSingInFormBlocBasedState createState() =>
      _EmailSingInFormBlocBasedState();
}

class _EmailSingInFormBlocBasedState extends State<EmailSingInFormBlocBased> {
  final TextEditingController _emailController = TextEditingController();
  // String email;
  final TextEditingController _passController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passFocusNode = FocusNode();

//  String get _email => _emailController.text;
//  String get _pass => _passController.text;
//  EmailSingInType _formtype = EmailSingInType.singin;
//  bool _submitted = false;
//  bool _isLoading = false;
  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    _passController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  void _emailEdittingCompleate(EmailSingInModel model) {
    final newFocus = widget.emailValidator.isvalid(model.email)
        ? _passFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  Future<void> _submit() async {
    try {
      await widget.bloc.submit();
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      //print(e.toString());
      PlatformExceptionAlertDialog(
        title: 'Sing in Failed ',
        exception: e,
      ).show(context);
    }
  }

  void _toggolForm(EmailSingInModel model) {
    widget.bloc.updateWith(
      email: '',
      pass: '',
      submitted: false,
      isLoading: false,
      formType: model.fromType == EmailSingInType.singin
          ? EmailSingInType.register
          : EmailSingInType.singin,
    );

    _emailController.clear();
    _passController.clear();
  }

  List<Widget> _buildChildren(EmailSingInModel model) {
    final primaryText = model.fromType == EmailSingInType.singin
        ? 'sing in'
        : 'create an account ';

    final secenderText = model.fromType == EmailSingInType.register
        ? 'meed an account ? register '
        : 'have a acount ? sing in';
    bool submitEnable = widget.emailValidator.isvalid(model.email) &&
        widget.passValidator.isvalid(model.pass) &&
        !model.isLoading;
    return [
      _buildEmailTextField(model),
      _buildPassTextField(model),
      FormSubmitButton(
        onPressed: submitEnable ? _submit : null,
        text: primaryText,
      ),
      FlatButton(
        onPressed: !model.isLoading ? () => _toggolForm(model) : null,
        child: Text(secenderText),
      )
    ];
  }

  TextField _buildPassTextField(EmailSingInModel model) {
    bool showErrorText =
        model.submitted && !widget.passValidator.isvalid(model.pass);
    return TextField(
      decoration: InputDecoration(
        enabled: model.isLoading == false,
        labelText: 'passWord',
        errorText: showErrorText ? widget.invalidePassError : null,
      ),
      obscureText: true,
      controller: _passController,
      textInputAction: TextInputAction.done,
      focusNode: _passFocusNode,
      onChanged: (pass) => widget.bloc.updateWith(pass: pass),
    );
  }

  TextField _buildEmailTextField(EmailSingInModel model) {
    bool showErrorText =
        model.submitted && !widget.emailValidator.isvalid(model.email);
    return TextField(
      decoration: InputDecoration(
        enabled: model.isLoading == false,
        labelText: 'Email',
        hintText: 'Test@email.com',
        errorText: showErrorText ? widget.invalideEmailError : null,
      ),
      controller: _emailController,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      focusNode: _emailFocusNode,
      onEditingComplete: () => _emailEdittingCompleate,
      onChanged: (email) => widget.bloc.updateWith(email: email),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSingInModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSingInModel(),
        builder: (context, snapshot) {
          final EmailSingInModel model = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _buildChildren(model),
            ),
          );
        });
  }

//  void _updateState() {
//    //  print('email is : $_email , pass is : $_pass');
//    setState(() {});
//  }
}

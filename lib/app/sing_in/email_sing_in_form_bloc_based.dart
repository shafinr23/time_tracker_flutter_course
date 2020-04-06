import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sing_in/emailSingInModel.dart';
import 'package:time_tracker_flutter_course/app/sing_in/email_sing_in_bloc.dart';
import 'package:time_tracker_flutter_course/common_widgets/form_submit_button.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class EmailSingInFormBlocBased extends StatefulWidget {
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
    final newFocus = model.emailValidator.isvalid(model.email)
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

  void _toggolForm() {
    widget.bloc.toggleFormType();

    _emailController.clear();
    _passController.clear();
  }

  List<Widget> _buildChildren(EmailSingInModel model) {
    return [
      _buildEmailTextField(model),
      _buildPassTextField(model),
      FormSubmitButton(
        onPressed: model.submitEnable ? _submit : null,
        text: model.primaryButtonText,
      ),
      FlatButton(
        onPressed: !model.isLoading ? _toggolForm : null,
        child: Text(model.seconderyButtonText),
      )
    ];
  }

  TextField _buildPassTextField(EmailSingInModel model) {
    return TextField(
      decoration: InputDecoration(
        enabled: model.isLoading == false,
        labelText: 'passWord',
        errorText: model.passErrorText,
      ),
      obscureText: true,
      controller: _passController,
      textInputAction: TextInputAction.done,
      focusNode: _passFocusNode,
      onChanged: widget.bloc.updateWithpass,
    );
  }

  TextField _buildEmailTextField(EmailSingInModel model) {
    return TextField(
      decoration: InputDecoration(
        enabled: model.isLoading == false,
        labelText: 'Email',
        hintText: 'Test@email.com',
        errorText: model.emailErrorText,
      ),
      controller: _emailController,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      focusNode: _emailFocusNode,
      onEditingComplete: () => _emailEdittingCompleate,
      onChanged: widget.bloc.updateWithEmail,
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

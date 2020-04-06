import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sing_in/emailSingInChangeModel.dart';
import 'package:time_tracker_flutter_course/common_widgets/form_submit_button.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class EmailSingInFormChangeNotifier extends StatefulWidget {
  EmailSingInFormChangeNotifier({@required this.model});
  final EmailSingInChangeModel model;
  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<EmailSingInChangeModel>(
      create: (context) => EmailSingInChangeModel(auth: auth),
      child: Consumer<EmailSingInChangeModel>(
        builder: (context, model, _) => EmailSingInFormChangeNotifier(
          model: model,
        ),
      ),
    );
  }

  @override
  _EmailSingInFormChangeNotifierState createState() =>
      _EmailSingInFormChangeNotifierState();
}

class _EmailSingInFormChangeNotifierState
    extends State<EmailSingInFormChangeNotifier> {
  final TextEditingController _emailController = TextEditingController();
  // String email;
  final TextEditingController _passController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passFocusNode = FocusNode();
  EmailSingInChangeModel get model => widget.model;

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

  void _emailEdittingCompleate() {
    final newFocus = model.emailValidator.isvalid(model.email)
        ? _passFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  Future<void> _submit() async {
    try {
      await model.submit();
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
    model.toggleFormType();

    _emailController.clear();
    _passController.clear();
  }

  List<Widget> _buildChildren() {
    return [
      _buildEmailTextField(),
      _buildPassTextField(),
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

  TextField _buildPassTextField() {
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
      onChanged: model.updateWithpass,
    );
  }

  TextField _buildEmailTextField() {
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
      onChanged: model.updateWithEmail,
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

//  void _updateState() {
//    //  print('email is : $_email , pass is : $_pass');
//    setState(() {});
//  }
}

import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter_course/app/sing_in/validator.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

import 'emailSingInModel.dart';

class EmailSingInChangeModel with EmailAndPasswordValidator, ChangeNotifier {
  EmailSingInChangeModel({
    @required this.auth,
    this.email = '',
    this.pass = '',
    this.fromType = EmailSingInType.singin,
    this.isLoading = false,
    this.submitted = false,
  });
  final AuthBase auth;
  String email;
  String pass;
  EmailSingInType fromType;
  bool isLoading;
  bool submitted;

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (fromType == EmailSingInType.singin) {
        await auth.singInWithEmailpass(email, pass);
      } else {
        await auth.regInWithEmailpass(email, pass);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
      //print(e.toString());
//      PlatformExceptionAlertDialog(
//        title: 'Sing in Failed ',
//        exception: e,
//      ).show(context);
    }
  }

  String get primaryButtonText {
    return fromType == EmailSingInType.singin
        ? 'sing in'
        : 'create an account ';
  }

  String get seconderyButtonText {
    return fromType == EmailSingInType.register
        ? 'meed an account ? register '
        : 'have a acount ? sing in';
  }

  bool get submitEnable {
    return emailValidator.isvalid(email) &&
        passValidator.isvalid(pass) &&
        !isLoading;
  }

  String get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isvalid(email);
    return showErrorText ? invalideEmailError : null;
  }

  String get passErrorText {
    bool showErrorText = submitted && !passValidator.isvalid(pass);
    return showErrorText ? invalidePassError : null;
  }

  void toggleFormType() {
    final formType = this.fromType == EmailSingInType.singin
        ? EmailSingInType.register
        : EmailSingInType.singin;
    updateWith(
      email: '',
      pass: '',
      submitted: false,
      isLoading: false,
      fromType: formType,
    );
  }

  void updateWithEmail(String email) => updateWith(email: email);
  void updateWithpass(String pass) => updateWith(pass: pass);

  void updateWith({
    final String email,
    final String pass,
    final EmailSingInType fromType,
    final bool isLoading,
    final bool submitted,
  }) {
    this.email = email ?? this.email;
    this.pass = pass ?? this.pass;
    this.fromType = fromType ?? this.fromType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter_course/app/sing_in/emailSingInModel.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class EmailSingInBloc {
  EmailSingInBloc({@required this.auth});
  final AuthBase auth;
  final StreamController<EmailSingInModel> _modelController =
      StreamController<EmailSingInModel>();
  Stream<EmailSingInModel> get modelStream => _modelController.stream;
  EmailSingInModel _model = EmailSingInModel();
  void dispose() {
    _modelController.close();
  }

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (_model.fromType == EmailSingInType.singin) {
        await auth.singInWithEmailpass(_model.email, _model.pass);
      } else {
        await auth.regInWithEmailpass(_model.email, _model.pass);
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

  void toggleFormType() {
    final formType = _model.fromType == EmailSingInType.singin
        ? EmailSingInType.register
        : EmailSingInType.singin;
    updateWith(
      email: '',
      pass: '',
      submitted: false,
      isLoading: false,
      formType: formType,
    );
  }

  void updateWithEmail(String email) => updateWith(email: email);
  void updateWithpass(String pass) => updateWith(pass: pass);
  void updateWith(
      {String email,
      String pass,
      EmailSingInType formType,
      bool isLoading,
      bool submitted}) {
    //update model
    _model = _model.copyWith(
      email: email,
      pass: pass,
      fromType: formType,
      isLoading: isLoading,
      submitted: submitted,
    );
    //add update model to _modelController
    _modelController.add(_model);
  }
}

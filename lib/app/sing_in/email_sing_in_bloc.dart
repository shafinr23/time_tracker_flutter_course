import 'dart:async';

import 'package:time_tracker_flutter_course/app/sing_in/emailSingInModel.dart';

class EmailSingInBloc {
  final StreamController<EmailSingInModel> _modelController =
      StreamController<EmailSingInModel>();
  Stream<EmailSingInModel> get modelStream => _modelController.stream;
  EmailSingInModel _model = EmailSingInModel();
  void dispose() {
    _modelController.close();
  }

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

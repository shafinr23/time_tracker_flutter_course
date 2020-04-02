import 'dart:async';

import 'package:time_tracker_flutter_course/app/sing_in/emailSingInModel.dart';

class EmailSingInBloc {
  final StreamController<EmailSingInModel> _modelController =
      StreamController<EmailSingInModel>();
  Stream<EmailSingInModel> get modelStream => _modelController.stream;
  void dispose() {
    _modelController.close();
  }
}

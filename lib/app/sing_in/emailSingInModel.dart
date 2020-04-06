import 'package:time_tracker_flutter_course/app/sing_in/validator.dart';

enum EmailSingInType { singin, register }

class EmailSingInModel with EmailAndPasswordValidator {
  EmailSingInModel({
    this.email = '',
    this.pass = '',
    this.fromType = EmailSingInType.singin,
    this.isLoading = false,
    this.submitted = false,
  });
  final String email;
  final String pass;
  final EmailSingInType fromType;
  final bool isLoading;
  final bool submitted;

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

  EmailSingInModel copyWith({
    final String email,
    final String pass,
    final EmailSingInType fromType,
    final bool isLoading,
    final bool submitted,
  }) {
    return EmailSingInModel(
      email: email ?? this.email,
      pass: pass ?? this.pass,
      fromType: fromType ?? this.fromType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }
}

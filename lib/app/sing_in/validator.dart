abstract class StringValidator {
  bool isvalid(String value);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isvalid(String value) {
    return value.isNotEmpty;
  }
}

class EmailAndPasswordValidator {
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passValidator = NonEmptyStringValidator();
  final String invalideEmailError = 'email can\'t be empty';
  final String invalidePassError = 'pass can\'t be empty';
}

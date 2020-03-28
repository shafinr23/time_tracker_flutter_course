abstract class StringValidator {
  bool isvalid(String value);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isvalid(String value) {
    return value.isNotEmpty;
  }
}

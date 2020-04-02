enum EmailSingInType { singin, register }

class EmailSingInModel {
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

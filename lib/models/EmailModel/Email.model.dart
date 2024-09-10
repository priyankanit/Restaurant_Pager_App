class EmailModel {
  String emailAddress;

  EmailModel({required this.emailAddress});

  bool isEmailValid() {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return emailRegex.hasMatch(emailAddress);
  }

  String getFormattedEmailAddress() {
    return emailAddress;
  }
}

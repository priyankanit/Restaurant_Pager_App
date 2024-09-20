class EmailModel {
  String? emailAddress;

  bool isEmailValid() {
    if(emailAddress == null) return false;
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return emailRegex.hasMatch(emailAddress!);
  }
}

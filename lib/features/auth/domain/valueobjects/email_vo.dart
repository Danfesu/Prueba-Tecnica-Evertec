class Email {
  final String value;

  Email(this.value) {
    if (!_isValidEmail(value)) {
      throw FormatException('Invalid email format');
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}

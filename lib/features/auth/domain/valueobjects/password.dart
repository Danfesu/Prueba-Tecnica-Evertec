class Password {
  final String value;

  Password(this.value) {
    if (!_isValidPassword(value)) {
      throw FormatException(
        'Invalid password format. Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one number.',
      );
    }
  }

  bool _isValidPassword(String password) {
    final passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }
}

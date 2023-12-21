class ValidationRegister {
  static const int _minLength = 6;

  static bool validateUsername(String username) {
    return username.length >= _minLength;
  }

  static bool validatePassword(String password) {
    return password.length >= _minLength;
  }

  static bool validateEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  static bool validateConfirmPassword(String password, String confirmPassword) {
    return password == confirmPassword && confirmPassword.length >= _minLength;
  }
}

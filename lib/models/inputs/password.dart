class Password {
  const Password(
    this.value, {
    this.errorText = Password.minChar,
    isValid = false,
  }) : this.isValid = isValid;

  final String value;
  final bool isValid;

  final String errorText;

  static const String minChar = "At least 6 characters!";
  static const String mustMatch = "Password must match!";

  static bool validate(String value) {
    if (value.length >= 6)
      return true;
    else
      return false;
  }
}

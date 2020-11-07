class Password {
  const Password(
    this.value, {
    isValid = false,
  }) : this.isValid = isValid;

  final String value;
  final bool isValid;

  final String errorText = "At least 6 characters!";

  static bool validate(String value) {
    if (value.length >= 6)
      return true;
    else
      return false;
  }
}

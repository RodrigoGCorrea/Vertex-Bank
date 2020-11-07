class Email {
  const Email(
    this.value, {
    isValid = false,
  }) : this.isValid = isValid;

  final String value;
  final bool isValid;

  static final _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  final String errorText = "Invalid email!";

  static bool validate(String value) {
    return _emailRegExp.hasMatch(value) ? true : false;
  }
}

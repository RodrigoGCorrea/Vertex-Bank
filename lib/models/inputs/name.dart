class Name {
  const Name(
    this.value, {
    isValid = false,
  }) : this.isValid = isValid;

  final String value;
  final bool isValid;

  static final _nameRegExp = RegExp(
    r"^/^[a-z ,.'-]+$/i$",
  );

  final String errorText = "Sorry... Invalid name.";

  static bool validate(String value) {
    return _nameRegExp.hasMatch(value) ? true : false;
  }
}

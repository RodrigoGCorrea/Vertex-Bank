class Name {
  const Name(
    this.value, {
    isValid = false,
  }) : this.isValid = isValid;

  final String value;
  final bool isValid;

  // static final _nameRegExp = RegExp(
  //   r"^[a-z ,.'-]+$/i$",
  // );

  final String errorText = "Sorry... Invalid name.";

  static bool validate(String value) {
    if (value.length > 0)
      return true;
    else
      return false;
  }
}

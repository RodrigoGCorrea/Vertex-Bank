class Birthday {
  const Birthday(
    this.value, {
    isValid = false,
  }) : this.isValid = isValid;

  final DateTime value;
  final bool isValid;

  final String errorText = "You must select your birthday.";

  static bool validate(DateTime value) {
    if (value != null)
      return true;
    else
      return false;
  }
}

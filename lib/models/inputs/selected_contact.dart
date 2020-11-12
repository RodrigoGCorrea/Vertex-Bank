class SelectedContact {
  const SelectedContact(
    this.value, {
    isValid = false,
  }) : this.isValid = isValid;

  final int value;
  final bool isValid;

  final String errorText = "Please, select a contact.";

  static bool validate(int value) {
    if (value >= 0)
      return true;
    else
      return false;
  }
}

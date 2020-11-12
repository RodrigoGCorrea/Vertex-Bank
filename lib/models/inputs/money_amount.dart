class MoneyAmount {
  const MoneyAmount(
    this.value, {
    isValid = false,
  }) : this.isValid = isValid;

  final double value;
  final bool isValid;

  final String errorText = "You can't make R\$0 transactions.";

  static bool validate(double value) {
    if (value > 0)
      return true;
    else
      return false;
  }
}

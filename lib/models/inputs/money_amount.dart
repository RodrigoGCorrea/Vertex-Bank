class MoneyAmount {
  const MoneyAmount(
    this.value, {
    isValid = false,
    this.errorText = MoneyAmount.valueIsZero,
  }) : this.isValid = isValid;

  final double value;
  final bool isValid;
  final String errorText;

  static const String valueIsZero = "You can't make R\$0 transactions.";
  static const String notEnoughMoney = "You don't have enough money.";

  static bool validate(double value) {
    if (value > 0)
      return true;
    else
      return false;
  }
}

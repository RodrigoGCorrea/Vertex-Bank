import 'package:meta/meta.dart';

class MoneyAmount {
  const MoneyAmount({
    @required this.value,
    isValid = false,
    this.errorText = MoneyAmount.valueIsZero,
  }) : this.isValid = isValid;

  final int value;
  final bool isValid;
  final String errorText;

  static const String valueIsZero = "You can't make R\$0 transactions.";
  static const String notEnoughMoney = "You don't have enough money.";

  static bool validate(int value) {
    if (value > 0)
      return true;
    else
      return false;
  }
}

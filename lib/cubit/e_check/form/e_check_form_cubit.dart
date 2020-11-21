import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:vertexbank/models/inputs/money_amount.dart';
import 'package:vertexbank/models/user.dart';

part 'e_check_form_state.dart';

class ECheckFormCubit extends Cubit<ECheckFormState> {
  ECheckFormCubit() : super(ECheckFormState.empty);

  void setUserInfo(User user) {
    emit(state.copyWith(
      senderId: user.id,
      userMoney: user.money,
    ));
  }

  void setECheckFormSelected() {
    emit(state.copyWith(
      stage: ECheckFormStage.selected,
    ));
    amountInputChanged(amountInt: state.amount.value);
  }

  void updateUserMoney(int amount) {
    emit(state.copyWith(userMoney: amount));
    amountInputChanged(amountInt: state.amount.value);
  }

  void amountInputChanged({double amountDouble, int amountInt}) {
    var amount;
    if (amountInt != null)
      amount = amountInt;
    else
      amount = (amountDouble * 100).toInt();

    bool isValid;
    String error = MoneyAmount.valueIsZero;

    if (!MoneyAmount.validate(amount))
      isValid = false;
    else if (state.userMoney < amount) {
      isValid = false;
      error = MoneyAmount.notEnoughMoney;
    } else
      isValid = true;

    emit(state.copyWith(
      amount: MoneyAmount(value: amount, isValid: isValid, errorText: error),
    ));
  }
}

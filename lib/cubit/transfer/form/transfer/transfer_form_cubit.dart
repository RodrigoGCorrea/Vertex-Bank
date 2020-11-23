import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vertexbank/api/transfer.dart';

import 'package:vertexbank/models/contact.dart';
import 'package:vertexbank/models/failure.dart';
import 'package:vertexbank/models/inputs/money_amount.dart';
import 'package:vertexbank/models/inputs/selected_contact.dart';
import 'package:vertexbank/models/transaction.dart';
import 'package:vertexbank/models/user.dart';

part 'transfer_form_state.dart';

class TransferFormCubit extends Cubit<TransferFormState> {
  TransferFormCubit({
    this.transferApi,
  }) : super(TransferFormState.empty);

  final TransferApi transferApi;

  void setUserInfo(User user) {
    emit(state.copyWith(
      userId: user.id,
      userName: user.name + " " + user.lastName,
    ));
  }

  void setContactList() async {
    try {
      final list = await transferApi.getContacts(state.userId);
      emit(state.copyWith(contactList: list));
    } on Failure {
      emit(state.copyWith(contactList: []));
    }
  }

  void selectContact(int index) {
    final int lastIndex = state.indexContactListSelected.value;
    final currentIndex = lastIndex == index ? -1 : index;
    final isValid = SelectedContact.validate(currentIndex);

    emit(state.copyWith(
      indexContactListSelected: SelectedContact(currentIndex, isValid: isValid),
    ));
  }

  void setTransferFormSelected() {
    final int index = state.indexContactListSelected.value;
    final Contact contact = state.contactList[index];
    final date = DateTime.now();

    // This will be in the sender transaction collection
    Transaction transactionSender = Transaction(
      id: contact
          .userID, //NOTE(Geraldo): eu acho que esse id não pera pra ser do
      //                            usuario e sim da propria transação, mas
      //                            por enquanto virou isso ai mesmo
      targetUser: contact.nickname,
      amount: state.amount.value,
      received: false,
      date: date,
    );

    // And this one will be in the receiver, meaning that received will be true
    Transaction transactionReceiver = Transaction(
      id: state.userId,
      targetUser: state.userName,
      amount: state.amount.value,
      received: true,
      date: date,
    );

    emit(state.copyWith(
      transactionSender: transactionSender,
      transactionReceiver: transactionReceiver,
      stage: TransferFormStage.selected,
    ));
  }

  void setTransferFormSelectedError() {
    emit(state.copyWith(
      stage: TransferFormStage.selected,
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

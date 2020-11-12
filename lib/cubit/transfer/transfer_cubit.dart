import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vertexbank/api/transfer.dart';

import 'package:vertexbank/models/contact.dart';
import 'package:vertexbank/models/failure.dart';
import 'package:vertexbank/models/inputs/money_amount.dart';
import 'package:vertexbank/models/inputs/selected_contact.dart';
import 'package:vertexbank/models/transaction.dart';

part 'transfer_state.dart';

class TransferCubit extends Cubit<TransferScreenState> {
  TransferCubit({
    this.transferApi,
  }) : super(TransferScreenState.empty);

  final TransferApi transferApi;

  void selectContact(int index) {
    final int lastIndex = state.indexContactListSelected.value;
    final currentIndex = lastIndex == index ? -1 : index;
    final isValid = SelectedContact.validate(currentIndex);

    emit(state.copyWith(
      indexContactListSelected: SelectedContact(currentIndex, isValid: isValid),
    ));
  }

  void cleanUpInitial() {
    emit(TransferScreenState.empty);
  }

  void cleanUpSelected() {
    emit(state.copyWith(
      transactionSender: Transaction.empty,
      transactionReceiver: Transaction.empty,
    ));
  }

  void completeTransfer(String senderId) async {
    try {
      final transactionSender = state.transactionSender;
      final transactionReceiver = state.transactionReceiver;
      await transferApi.makeTransfer(
        senderId,
        transactionSender.id,
        transactionSender,
        transactionReceiver,
      );
    } on Failure catch (e) {
      //TODO(Geraldo): fazer uma splash screen para mostrar o erro
      //               e adicionar states da transferencia: loading, error
      print(e.message);
    }
  }

  void proceedTransfer(String senderId, String senderName) {
    if (state.indexContactListSelected.isValid && state.amount.isValid) {
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
        amount: state.amount,
        received: false,
        date: date,
      );

      // And this one will be in the receiver, meaning that received will be true
      Transaction transactionReceiver = Transaction(
        id: senderId,
        targetUser: senderName,
        amount: state.amount,
        received: true,
        date: date,
      );

      emit(state.copyWith(
        transactionSender: transactionSender,
        transactionReceiver: transactionReceiver,
        stage: TransferScreenStage.selected,
      ));
    } else {
      emit(state.copyWith(
        stage: TransferScreenStage.selected,
      ));
      amountChanged(state.amount.value, 0);
    }
  }

  void setContactList(String id) async {
    try {
      final list = await transferApi.getContacts(id);
      emit(state.copyWith(
        contactList: list,
      ));
    } on Failure {
      emit(state.copyWith(
        contactList: [],
      ));
    }
  }

  void amountChanged(double amount, double userMoney) {
    bool isValid;
    String error = MoneyAmount.valueIsZero;

    if (!MoneyAmount.validate(amount))
      isValid = false;
    else if (userMoney < amount) {
      isValid = false;
      error = MoneyAmount.notEnoughMoney;
    } else
      isValid = true;

    emit(state.copyWith(
      amount: MoneyAmount(amount, isValid: isValid, errorText: error),
    ));
  }
}

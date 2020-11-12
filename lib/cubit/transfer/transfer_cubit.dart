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
      transaction: Transaction.empty,
    ));
  }

  void proceedTransfer() {
    if (state.indexContactListSelected.isValid && state.amount.isValid) {
      final int index = state.indexContactListSelected.value;
      final Contact contact = state.contactList[index];
      Transaction transaction = Transaction(
        id: contact.userID,
        targetUser: contact.nickname,
        amount: state.amount,
        received: false,
        date: DateTime.now(),
      );
      emit(state.copyWith(
        transaction: transaction,
        stage: TransferScreenStage.selected,
      ));
    } else {
      emit(state.copyWith(
        stage: TransferScreenStage.selected,
      ));
      amountChanged(state.amount.value);
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

  void amountChanged(double amount) {
    final isValid = MoneyAmount.validate(amount);

    emit(state.copyWith(
      amount: MoneyAmount(amount, isValid: isValid),
    ));
  }
}

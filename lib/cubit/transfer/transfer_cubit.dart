import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:vertexbank/models/contact.dart';
import 'package:vertexbank/models/transaction.dart';

part 'transfer_state.dart';

class TransferCubit extends Cubit<TransferScreenState> {
  TransferCubit() : super(TransferScreenState.empty);

  void selectContact(int index) {
    final int lastIndex = state.indexContactListSelected;
    final currentIndex = lastIndex == index ? -1 : index;

    emit(state.copyWith(
      indexContactListSelected: currentIndex,
    ));
  }

  void cleanUpInitial() {
    emit(TransferScreenState.empty);
  }

  void cleanUpSelected() {
    emit(state.copyWith(
      transaction: Transaction.empty,
      stage: TransferScreenStage.initial,
    ));
  }

  void proceedTransfer() {
    //NOTE(Geraldo): Lidar com erro pra exibir pro usuario na UI dps
    if (state.indexContactListSelected == null) return null;

    final int index = state.indexContactListSelected;
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
  }

  //NOTE(Geraldo): Essa função provavelmente vai sair ao integrara essa tela com firebase
  void setContactList(List<Contact> list) {
    emit(state.copyWith(
      contactList: list,
    ));
  }

  void amountChanged(String amount) {
    emit(state.copyWith(
      amount: amount,
    ));
  }
}

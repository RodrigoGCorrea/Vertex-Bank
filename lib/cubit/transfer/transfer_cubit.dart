import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:vertexbank/models/contact.dart';
import 'package:vertexbank/models/transaction.dart';

part 'transfer_state.dart';

class TransferCubit extends Cubit<TransferScreenState> {
  TransferCubit()
      : super(TransferScreenInitial(
          contactList: [],
          indexContactListSelected: -1,
          amount: '0',
        ));

  void selectContact(int index) {
    final lstate = state as TransferScreenInitial;

    final int lastIndex = lstate.indexContactListSelected;
    final currentIndex = lastIndex == index ? -1 : index;

    emit(lstate.copyWith(
      indexContactListSelected: currentIndex,
    ));
  }

  void proceedTransfer() {
    final lstate = state as TransferScreenInitial;

    //NOTE(Geraldo): Lidar com erro pra exibir pro usuario na UI dps
    if (lstate.indexContactListSelected == null) return null;

    final int index = lstate.indexContactListSelected;
    final Contact contact = lstate.contactList[index];

    Transaction transaction = Transaction(
      id: contact.userID,
      name: contact.nickname,
      amount: lstate.amount,
      received: false,
      date: DateTime.now(),
    );
    emit(TransferScreenSelected(transaction: transaction));
  }

  //NOTE(Geraldo): Essa função provavelmente vai sair ao integrara essa tela com firebase
  void setContactList(List<Contact> list) {
    final lstate = state as TransferScreenInitial;

    emit(lstate.copyWith(
      contactList: list,
    ));
  }

  void amountChanged(String amount) {
    final lstate = state as TransferScreenInitial;

    emit(lstate.copyWith(
      amount: amount,
    ));
  }
}

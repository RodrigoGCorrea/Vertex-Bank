import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:vertexbank/components/transferscreen/contactlist.dart';
import 'package:vertexbank/models/contact.dart';
import 'package:vertexbank/models/transaction.dart';

part 'transfer_state.dart';

class TransferCubit extends Cubit<TransferScreenState> {
  TransferCubit()
      : super(TransferScreenInitial(
          contactList: [],
          indexContactListSelected: null,
          amount: '0',
        ));

  void selectContact(int index) {
    final lstate = state as TransferScreenInitial;

    List<ContactListItem> listState = lstate.contactList;
    int lastIndex = lstate.indexContactListSelected;
    listState[index].isSelected = !listState[index].isSelected;

    if (lastIndex != null) {
      listState[lastIndex].isSelected = false;
    }

    if (lastIndex == index)
      lastIndex = null;
    else
      lastIndex = index;

    emit(lstate.copyWith(
      contactList: listState,
      indexContactListSelected: lastIndex,
    ));
  }

  void proceedTransfer() {
    final lstate = state as TransferScreenInitial;

    if (lstate.indexContactListSelected == null) return null;
    List<ContactListItem> listState = lstate.contactList;
    int lastIndex = lstate.indexContactListSelected;
    String amountState = lstate.amount;

    Contact contact = listState[lastIndex].contact;
    Transaction transaction = Transaction(
      id: contact.userID,
      name: contact.nickname,
      amount: amountState,
      received: false,
      date: DateTime.now(),
    );
    emit(TransferScreenSelected(transaction: transaction));
  }

  //NOTE(Geraldo): Essa função provavelmente vai sair ao integrara essa tela com firebase
  void setContactList(List<ContactListItem> list) {
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

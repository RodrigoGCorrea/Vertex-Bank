import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vertexbank/components/transferscreen/contactlist.dart';
import 'package:vertexbank/models/Contact.dart';
import 'package:vertexbank/models/transaction.dart';

part 'transferscreen_state.dart';

class TransferScreenCubit extends Cubit<TransferScreenState> {
  TransferScreenCubit()
      : super(TransferScreenInitial(
          contactList: [],
          indexContactListSelected: null,
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
    emit(TransferScreenInitial(
      contactList: listState,
      indexContactListSelected: lastIndex,
    ));
  }

  Transaction proceedTransfer() {
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

  void setContactList(List<ContactListItem> list) {
    emit(TransferScreenInitial(
      contactList: list,
      indexContactListSelected: null,
    ));
  }

  void amountChanged(String amount) {
    final lstate = state as TransferScreenInitial;
    emit(lstate.copyWith(amount: amount));
    print(lstate.amount);
  }
}

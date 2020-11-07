part of 'transfer_cubit.dart';

abstract class TransferScreenState extends Equatable {
  const TransferScreenState();

  @override
  List<Object> get props => [];
}

class TransferScreenInitial extends TransferScreenState {
  final List<Contact> contactList;
  final int indexContactListSelected;
  final String amount;

  const TransferScreenInitial({
    @required this.amount,
    @required this.contactList,
    @required this.indexContactListSelected,
  }) : super();

  TransferScreenInitial copyWith({
    List<Contact> contactList,
    int indexContactListSelected,
    String amount,
  }) {
    return TransferScreenInitial(
      contactList: contactList ?? this.contactList,
      indexContactListSelected:
          indexContactListSelected ?? this.indexContactListSelected,
      amount: amount ?? this.amount,
    );
  }

  @override
  List<Object> get props => [contactList, indexContactListSelected, amount];
}

class TransferScreenSelected extends TransferScreenState {
  final Transaction transaction;

  TransferScreenSelected({
    this.transaction,
  });

  TransferScreenSelected copyWith({
    Transaction transaction,
  }) {
    return TransferScreenSelected(
      transaction: transaction ?? this.transaction,
    );
  }

  @override
  List<Object> get props => [transaction];
}
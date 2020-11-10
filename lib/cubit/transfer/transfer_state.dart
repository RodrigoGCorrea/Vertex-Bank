part of 'transfer_cubit.dart';

enum TransferScreenStage { initial, selected }

class TransferScreenState extends Equatable {
  final List<Contact> contactList;
  final int indexContactListSelected;
  final String amount;
  final Transaction transaction;
  final TransferScreenStage stage;

  const TransferScreenState({
    @required this.stage,
    @required this.transaction,
    @required this.amount,
    @required this.contactList,
    @required this.indexContactListSelected,
  }) : super();

  static final empty = TransferScreenState(
    stage: TransferScreenStage.initial,
    contactList: [],
    indexContactListSelected: -1,
    amount: '0',
    transaction: Transaction.empty,
  );

  TransferScreenState copyWith({
    List<Contact> contactList,
    int indexContactListSelected,
    String amount,
    Transaction transaction,
    TransferScreenStage stage,
  }) {
    return TransferScreenState(
      contactList: contactList ?? this.contactList,
      indexContactListSelected:
          indexContactListSelected ?? this.indexContactListSelected,
      amount: amount ?? this.amount,
      transaction: transaction ?? this.transaction,
      stage: stage ?? this.stage,
    );
  }

  @override
  List<Object> get props => [
        contactList,
        indexContactListSelected,
        amount,
        transaction,
      ];
}

part of 'transfer_cubit.dart';

enum TransferScreenStage { initial, selected }

class TransferScreenState extends Equatable {
  final List<Contact> contactList;
  final SelectedContact indexContactListSelected;
  final MoneyAmount amount;
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
    indexContactListSelected: SelectedContact(-1),
    amount: MoneyAmount(0),
    transaction: Transaction.empty,
  );

  TransferScreenState copyWith({
    List<Contact> contactList,
    SelectedContact indexContactListSelected,
    MoneyAmount amount,
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

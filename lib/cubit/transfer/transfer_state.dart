part of 'transfer_cubit.dart';

enum TransferScreenStage { initial, selected }

class TransferScreenState extends Equatable {
  final List<Contact> contactList;
  final SelectedContact indexContactListSelected;
  final MoneyAmount amount;
  final Transaction transactionSender;
  final Transaction transactionReceiver;
  final TransferScreenStage stage;

  const TransferScreenState({
    @required this.stage,
    @required this.transactionSender,
    @required this.transactionReceiver,
    @required this.amount,
    @required this.contactList,
    @required this.indexContactListSelected,
  }) : super();

  static final empty = TransferScreenState(
    stage: TransferScreenStage.initial,
    contactList: [],
    indexContactListSelected: SelectedContact(-1),
    amount: MoneyAmount(0),
    transactionSender: Transaction.empty,
    transactionReceiver: Transaction.empty,
  );

  TransferScreenState copyWith({
    List<Contact> contactList,
    SelectedContact indexContactListSelected,
    MoneyAmount amount,
    Transaction transactionSender,
    Transaction transactionReceiver,
    TransferScreenStage stage,
  }) {
    return TransferScreenState(
      contactList: contactList ?? this.contactList,
      indexContactListSelected:
          indexContactListSelected ?? this.indexContactListSelected,
      amount: amount ?? this.amount,
      transactionSender: transactionSender ?? this.transactionSender,
      transactionReceiver: transactionReceiver ?? this.transactionReceiver,
      stage: stage ?? this.stage,
    );
  }

  @override
  List<Object> get props => [
        contactList,
        indexContactListSelected,
        amount,
        transactionSender,
        transactionReceiver,
        stage,
      ];
}

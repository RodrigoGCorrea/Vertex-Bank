part of 'transfer_form_cubit.dart';

enum TransferFormStage { initial, selected }

class TransferFormState extends Equatable {
  final List<Contact> contactList;
  final SelectedContact indexContactListSelected;
  final MoneyAmount amount;
  final Transaction transactionSender;
  final Transaction transactionReceiver;
  final TransferFormStage stage;
  final User userInfo;

  const TransferFormState({
    @required this.stage,
    @required this.transactionSender,
    @required this.transactionReceiver,
    @required this.amount,
    @required this.contactList,
    @required this.indexContactListSelected,
    @required this.userInfo,
  }) : super();

  static final empty = TransferFormState(
    stage: TransferFormStage.initial,
    contactList: [],
    indexContactListSelected: SelectedContact(-1),
    amount: MoneyAmount(0),
    transactionSender: Transaction.empty,
    transactionReceiver: Transaction.empty,
    userInfo: User.empty,
  );

  TransferFormState copyWith({
    List<Contact> contactList,
    SelectedContact indexContactListSelected,
    MoneyAmount amount,
    Transaction transactionSender,
    Transaction transactionReceiver,
    TransferFormStage stage,
    User userInfo,
  }) {
    return TransferFormState(
      contactList: contactList ?? this.contactList,
      indexContactListSelected:
          indexContactListSelected ?? this.indexContactListSelected,
      amount: amount ?? this.amount,
      transactionSender: transactionSender ?? this.transactionSender,
      transactionReceiver: transactionReceiver ?? this.transactionReceiver,
      stage: stage ?? this.stage,
      userInfo: userInfo ?? this.userInfo,
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
        userInfo,
      ];
}

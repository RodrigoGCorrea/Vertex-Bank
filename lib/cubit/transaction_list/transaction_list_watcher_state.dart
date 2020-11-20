part of 'transaction_list_watcher_cubit.dart';

class TransactionListState extends Equatable {
  const TransactionListState({
    @required this.transactionList,
  });

  final List<Transaction> transactionList;

  @override
  List<Object> get props => [transactionList];
}

part of 'transaction_list_watcher_cubit.dart';

class TransactionListWatcherState extends Equatable {
  const TransactionListWatcherState({
    @required this.transactionList,
  });

  final List<Transaction> transactionList;

  @override
  List<Object> get props => [transactionList];
}

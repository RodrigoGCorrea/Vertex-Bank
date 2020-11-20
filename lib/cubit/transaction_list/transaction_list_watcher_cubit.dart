import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:vertexbank/api/transaction_list.dart';
import 'package:vertexbank/models/failure.dart';
import 'package:vertexbank/models/transaction.dart';

part 'transaction_list_watcher_state.dart';

class TransactionListCubit extends Cubit<TransactionListState> {
  TransactionListCubit({
    @required this.transactionListApi,
  }) : super(TransactionListState(transactionList: []));

  final TransactionListApi transactionListApi;
  StreamSubscription<List<Transaction>> _transactionListSubscription;

  void setTransactionListWatcher(String id) async {
    try {
      await _transactionListSubscription?.cancel();
      _transactionListSubscription =
          transactionListApi.watchTransactionList(id).listen((transactionList) {
        emit(TransactionListState(transactionList: transactionList));
      });
    } on Failure catch (e) {
      print(e);
    }
  }

  @override
  Future<void> close() async {
    await _transactionListSubscription?.cancel();
    return super.close();
  }
}

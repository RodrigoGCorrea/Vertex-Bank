import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vertexbank/api/money.dart';

part 'money_watcher_state.dart';

class MoneyWatcherCubit extends Cubit<MoneyWatcherState> {
  MoneyWatcherCubit({
    @required this.moneyApi,
  }) : super(MoneyWatcherState(money: 0));

  final MoneyApi moneyApi;
  StreamSubscription<int> _moneySubscription;

  void setMoneyWatcher(String id) async {
    try {
      await _moneySubscription?.cancel();
      _moneySubscription = moneyApi.watchMoneyFromUser(id).listen((money) {
        emit(MoneyWatcherState(money: money));
      });
    } on Error catch (e) {
      //This should never reach!!!
      print(e);
    }
  }

  @override
  Future<void> close() async {
    await _moneySubscription?.cancel();
    return super.close();
  }
}

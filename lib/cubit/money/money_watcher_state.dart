part of 'money_watcher_cubit.dart';

class MoneyWatcherState extends Equatable {
  const MoneyWatcherState({
    @required this.money,
  });

  final int money;

  @override
  List<Object> get props => [
        money,
      ];
}

import 'package:get_it/get_it.dart';
import 'package:vertexbank/api/auth.dart';
import 'package:vertexbank/api/money.dart';
import 'package:vertexbank/api/transaction_list.dart';
import 'package:vertexbank/api/transfer.dart';

final getIt = GetIt.instance;

void getItSetup() {
  getIt.registerSingleton<AuthApi>(AuthApi());
  getIt.registerLazySingleton<TransferApi>(() => TransferApi());
  getIt.registerLazySingleton<MoneyApi>(() => MoneyApi());
  getIt.registerLazySingleton<TransactionListApi>(() => TransactionListApi());
}
